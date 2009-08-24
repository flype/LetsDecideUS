require 'test_helper'

class AnswerTest < ActiveSupport::TestCase

  test "has_expired? true" do
    @question = Factory(:question)
    @answer1 = Factory( :answer, :question => @question, :vote => '-1', :mail =>"felipe.talavera@gmail.com", :name => "felipe talavera", :mail_date => Time.local( 2009, 1, 10 ) )
    @answer2 = Factory( :answer, :question => @question, :vote => '-1', :mail =>"felipe.talavera@gmail.com", :name => "felipe talavera", :mail_date => Time.local( 2009, 1, 11 ) )
    
    assert( @answer1.has_expired? )
    assert( !@answer2.has_expired? )    
  end

end
