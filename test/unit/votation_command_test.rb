require 'test_helper'

class VotationCommandTest < ActiveSupport::TestCase
  test "on results should send a results email" do
    @question = Factory(:question)
    BotMailer.expects(:deliver_results).with( @question, 'wadus' ).once
    VotationCommand.results( @question, 'wadus' )
  end
  
  test "on web should send a web email" do
    @question = Factory(:question)
    BotMailer.expects(:deliver_web).with( @question, 'wadus' ).once
    VotationCommand.web( @question, 'wadus' )
  end
end