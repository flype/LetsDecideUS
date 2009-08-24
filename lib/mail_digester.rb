# require 'net/imap'
# require 'rubygems'
# require 'tmail'
# require 'votation_parser'
require 'lockfile'

class MailDigester
  def self.run
    Lockfile.new('/tmp/mail_digester.lock') do
      begin
        RAILS_DEFAULT_LOGGER.info( "[mail_digester]\t#{Time.now().to_s(:db)}: running mail digest" )
        lapsus_time = 
          Benchmark.realtime do
            self.process
          end
        RAILS_DEFAULT_LOGGER.info( "[mail_digester]\t#{Time.now().to_s(:db)}: completed on #{lapsus_time.to_i} seconds" )
      rescue Exception => e
        RAILS_DEFAULT_LOGGER.error( "[mail_digester]\t#{Time.now().to_s(:db)}: ERROR: #{e.message}" )
        e.backtrace.each do |backtrace_line|
          RAILS_DEFAULT_LOGGER.error( backtrace_line )
        end
        BotMailer.deliver_exception( e )
      end
    end
  end
  
  def self.process
    imap = Net::IMAP.new(CONFIG[:bot_mail_server])
    imap.authenticate('LOGIN', CONFIG[:bot_mail], CONFIG[:bot_mail_pass])
    imap.examine('INBOX')

    imap.search(["NOT", "SEEN"]).each do |message_id|
      msg = imap.fetch(message_id,'RFC822')[0].attr['RFC822']
      mail = TMail::Mail.parse(msg)  
      VotationParser.parse(mail)  
      RAILS_DEFAULT_LOGGER.info("[mail_digester]\t#{Time.now().to_s(:db)}: from: #{mail.from.to_s}, \tto: #{mail.to} \t#{mail.subject}\t #{"preguntaza!" if /\?$/ =~ mail.subject}")
      imap.store(message_id, "+FLAGS", [:Seen])  
    end
  end
end