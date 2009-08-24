require 'test_helper'

class MailDigesterTest < ActiveSupport::TestCase
  test "on run if exception should send email" do
    begin
      raise Exception.new
    rescue Exception => e
      @exception = e
    end
    
    MailDigester.expects(:process).raises(@exception).once
    BotMailer.expects(:deliver_exception).with(@exception).once
    
    MailDigester.run
  end
end