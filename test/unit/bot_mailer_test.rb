require 'test_helper'

class BotMailerTest < ActionMailer::TestCase
  test "results" do
    @question = Factory(:question, :qhash => 'wadus_hash')
    Factory( :answer, :question => @question, :vote => '+1', :mail_date => Time.local( 2009, 2 ), :mail => 'pepe@pepe.com', :name => 'pepe' )
    Factory( :answer, :question => @question, :vote => '+1', :mail_date => Time.local( 2009, 3 ) )
    Factory( :answer, :question => @question, :vote => '+1', :mail_date => Time.local( 2009, 4 ), :mail => 'pepe@pepe.com', :name => 'pepe' )
    Factory( :answer, :question => @question, :vote => '-1', :mail_date => Time.local( 2009, 5 ), :name => nil )
    
    @expected.subject = "Re: #{@question.subject}"
    @expected.body    = read_fixture('results')
    @expected.date    = Time.now
    @expected.from    = CONFIG[:bot_mail]
    @expected.to      = @question.mails.to_a
    
    # puts BotMailer.create_results(@question, 'wadus@wadus.com').body

    assert_equal @expected.encoded, BotMailer.create_results(@question, 'wadus@wadus.com', @expected.date).encoded
  end

  test "web" do
    @question = Factory(:question, :qhash => 'wadus_hash')
    
    @expected.subject = "Re: #{@question.subject}"
    @expected.body    = read_fixture('web')
    @expected.date    = Time.now
    @expected.from    = CONFIG[:bot_mail]
    @expected.to      = @question.mails.to_a
    
    # puts BotMailer.create_web(@question, 'wadus@wadus.com').body

    assert_equal @expected.encoded, BotMailer.create_web(@question, 'wadus@wadus.com', @expected.date).encoded
  end
  
  test "exception" do    
    begin
      raise Exception.new( 'wadus mensaje' )
    rescue Exception => e
      @exception = e
    end
    
    @expected.subject = "LetsDecideUs EXCEPTION: #{@exception.message}"
    @expected.body    = read_fixture('exception')
    @expected.date    = Time.now
    @expected.from    = CONFIG[:bot_mail]
    @expected.to      = CONFIG[:admin_mails].split(',')
    
    # puts BotMailer.create_exception(@exception).body
    # 
    # File.open( "/tmp/xxxx.txt", 'w' ) do |f|
    #   f.write BotMailer.create_exception(@exception).body
    # end
    
    mail = BotMailer.create_exception(@exception, @expected.date)

    assert_equal( @expected.subject, mail.subject )
    assert_equal( @expected.from, mail.from )
    assert_equal( @expected.to, mail.to )
    assert_match(/wadus mensaje/, mail.body )
    
    # assert_equal @expected.encoded, BotMailer.create_exception(@exception, @expected.date).encoded
  end

end
