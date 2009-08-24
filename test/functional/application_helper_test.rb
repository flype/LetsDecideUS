require 'test_helper'

class ApplicationHelperTest < ActiveSupport::TestCase
  include ApplicationHelper

  def test_answer_name_or_mail
    assert_equal( 'pepe', self.answer_name_or_mail( Factory(:answer, :name => "pepe", :mail => 'pepe@pepe.com' ) ) )
    assert_equal( 'pepe on pepe.com', self.answer_name_or_mail( Factory(:answer, :name => nil, :mail => 'pepe@pepe.com' ) ) )
    assert_equal( 'pepe on pepe.com', self.answer_name_or_mail( Factory(:answer, :name => '=?ISO-8859-1?Q?=C1lvaro_Bautista?=', :mail => 'pepe@pepe.com' ) ) )
  end
  
  def test_question_name_or_mail
    @question = Factory(:question, :owner_name => "pepe", :owner_mail => 'pepe@pepe.com' )
    assert_equal( 'pepe', self.question_name_or_mail )
    
    @question = Factory(:question, :owner_name => nil, :owner_mail => 'pepe@pepe.com' )
    assert_equal( 'pepe on pepe.com', self.question_name_or_mail )
    
    @question = Factory(:question, :owner_name => "=?ISO-8859-1?Q?=C1lvaro_Bautista?=", :owner_mail => 'pepe@pepe.com' )
    assert_equal( 'pepe on pepe.com', self.question_name_or_mail )
    
  end
end