namespace :ldu do  
  desc 'Call to MailDigester'
  task :mail_digest => :environment do 
    RAILS_DEFAULT_LOGGER.info( "[mail_digester]\t(#{Time.now().to_s(:db)}) MailDigester calling" )
    MailDigester.run
  end
end