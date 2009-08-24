require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  test "answers_wihout_duplicated" do
    @question = Factory(:question)
    Factory( :answer, :question => @question, :mail => 'pepe@pepe.com', :mail_date => Time.local( 2009, 1, 10 ) )
    Factory( :answer, :question => @question, :mail => 'pepe@pepe.com', :mail_date => Time.local( 2009, 1, 11 )  )
    Factory( :answer, :question => @question, :mail => 'maria@pepe.com', :mail_date => Time.local( 2009, 1, 12 )  )
    Factory( :answer, :question => @question, :mail => 'pepe@pepe.com', :mail_date => Time.local( 2009, 1, 13 )  )
    Factory( :answer, :question => @question, :mail => 'maria@pepe.com', :mail_date => Time.local( 2009, 1, 14 )  )
 
    # @question.answers.all( :order => 'created_at desc' ).map{ |a| puts "#{a.mail} - #{a.created_at.to_s(:db)}" }
    # @question.answers_without_duplicated.map{ |a| puts "#{a.mail} - #{a.created_at.to_s(:db)}" }
    
    assert_equal( 2, @question.answers_without_duplicated.size )
    assert_equal( 'maria@pepe.com', @question.answers_without_duplicated.first.mail )
    assert_equal( 'pepe@pepe.com', @question.answers_without_duplicated.last.mail )
    assert_equal( '2009-01-13 23:00:00', @question.answers_without_duplicated.first.mail_date.to_s(:db) )
    assert_equal( '2009-01-12 23:00:00', @question.answers_without_duplicated.last.mail_date.to_s(:db) )
  end
    
  test "plus_counter_without_duplicated should return 3 if 3 plus votes" do
    @question = Factory(:question)
    Factory( :answer, :question => @question, :vote => '+1' )
    Factory( :answer, :question => @question, :vote => '+1' )
    Factory( :answer, :question => @question, :vote => '+1' )
    Factory( :answer, :question => @question, :vote => '-1' )
    
    assert_equal( 3, @question.plus_counter_without_duplicated )
  end

  test "minus_counter_without_duplicated should return 2 if 2 minus votes" do
    @question = Factory(:question)
    Factory( :answer, :question => @question, :vote => '+1' )
    Factory( :answer, :question => @question, :vote => '-1' )
    Factory( :answer, :question => @question, :vote => '+1' )
    Factory( :answer, :question => @question, :vote => '-1' )
    
    assert_equal( 2, @question.minus_counter_without_duplicated )
  end
  
  test "plus_counter_with_duplicated should return 2 if 3 plus votes with 2 repeated" do
    @question = Factory(:question)
    Factory( :answer, :question => @question, :vote => '+1', :mail =>"felipe.talavera@gmail.com", :name => "felipe talavera" )
    Factory( :answer, :question => @question, :vote => '+1', :mail =>"felipe.talavera@gmail.com", :name => "felipe talavera"  )
    Factory( :answer, :question => @question, :vote => '+1' )
    Factory( :answer, :question => @question, :vote => '-1' )
    
    assert_equal( 2, @question.plus_counter_without_duplicated )
    assert_equal( 3, @question.plus_counter_with_duplicated )    
  end

  test "minus_counter_with_duplicated should return 1 if 2 minus votes repeated" do
    @question = Factory(:question)
    Factory( :answer, :question => @question, :vote => '+1' )
    Factory( :answer, :question => @question, :vote => '-1', :mail =>"felipe.talavera@gmail.com", :name => "felipe talavera" )
    Factory( :answer, :question => @question, :vote => '+1' )
    Factory( :answer, :question => @question, :vote => '-1', :mail =>"felipe.talavera@gmail.com", :name => "felipe talavera" )
    
    assert_equal( 1, @question.minus_counter_without_duplicated )
    assert_equal( 2, @question.minus_counter_with_duplicated )    
  end
  
  test "votation_result YES win" do
    @question = Factory(:question)
    Factory( :answer, :question => @question, :vote => '+1')
    Factory( :answer, :question => @question, :vote => '+1')
    Factory( :answer, :question => @question, :vote => '+1')
    Factory( :answer, :question => @question, :vote => '-1')
    Factory( :answer, :question => @question, :vote => '-1')
    
    assert_equal( "YES", @question.votation_result )
  end
  
  test "votation_result NO win" do
    @question = Factory(:question)
    Factory( :answer, :question => @question, :vote => '-1')
    Factory( :answer, :question => @question, :vote => '+1')
    Factory( :answer, :question => @question, :vote => '-1')
    
    assert_equal( "NO", @question.votation_result )
  end
  
  test "votation_result DEUCE" do
    @question = Factory(:question)
    Factory( :answer, :question => @question, :vote => '-1')
    Factory( :answer, :question => @question, :vote => '+1')
    
    assert_equal( "DEUCE", @question.votation_result )
  end
end
