require 'test_helper'

class VotationParserTest < ActiveSupport::TestCase
  test "should I put attention returns true if is a question" do
    tmail = self.parse_mail( "a_plus_one_vote" )    
    tmail.expects(:subject).returns( "this is a question?" ).once
    assert( VotationParser.should_i_put_attention?( tmail ) )
  end
  
  test "should I put attention returns false if is not a question" do
    tmail = self.parse_mail( "a_plus_one_vote" )    
    tmail.expects(:subject).returns( "this is not question" ).once
    assert( !VotationParser.should_i_put_attention?( tmail ) )
  end
  
  test "should I put attention returns false if its a reply of the bot" do
    tmail = self.parse_mail( "bot_mail" )    
    assert( !VotationParser.should_i_put_attention?( tmail ) )
  end

  test "should I put attention returns also with spaces at the end" do
    tmail = self.parse_mail( "a_plus_one_vote" )    
    tmail.expects(:subject).returns( "this is also a question ?  " ).once
    assert( VotationParser.should_i_put_attention?( tmail ) )
  end
  
  test "extract vote should respond with +1" do
    tmail = self.parse_mail( "a_plus_one_vote" )
    assert_equal( '+1', VotationParser.extract_vote( tmail ) )
  end
  
  test "extract vote should respond with -1" do
    tmail = self.parse_mail( "a_minus_one_vote" )
    assert_equal( '-1', VotationParser.extract_vote( tmail ) )
  end
  
  test "extract vote should respond nil if not vote found" do
    tmail = self.parse_mail( "simple_question" )
    assert_nil( VotationParser.extract_vote( tmail ) )
  end
  
  
  test "parse question should create a Question" do
    tmail = self.parse_mail( "simple_question" )
    
    assert_difference "Question.count", 1 do
      @question = VotationParser.parse_question( tmail )
    end
  
    assert_equal( "this is a question?", @question.subject )
    assert_equal( tmail.subject, Marshal.load(@question.raw_mail).subject)
    assert_not_nil( @question.qhash )
    assert_equal( "XXX@gmail.com", @question.mails )
    assert_equal( "XXX@gmail.com", @question.owner_mail )
    assert_equal( '2009-08-22 12:22:33', @question.mail_date.to_s(:db) )
  end
  
  test "parse question should NOT create a Question if already exists" do
    tmail = self.parse_mail( "simple_question" )
    
    VotationParser.expects(:exists_question?).returns(true).once
    
    assert_difference "Question.count", 0 do
      @question = VotationParser.parse_question( tmail )
    end
  end
  
  test "on exists_question? should return true" do
    @question = Factory( :question, :qhash => 'xxx' )
    VotationParser.expects(:create_qhash).returns( @question.qhash ).once
    assert_equal( @question, VotationParser.exists_question?( parse_mail( 'simple_question' ) ) )
  end
  
  test "on exists_question? should return nil" do
    @question = Factory( :question, :qhash => 'xxx' )
    VotationParser.expects(:create_qhash).returns( "#{@question.qhash} wadus" ).once
    assert_nil( VotationParser.exists_question?( parse_mail( 'simple_question' ) ) )
  end
  
  test "on extract_mails should return 3 emails" do
    tmail = self.parse_mail( "five_destinies" )
    
    mails = [
      "ana@fernandoguillen.info",
      # "bot@letsdecide.us",
      "juan@fernandoguillen.info",
      "maria@fernandoguillen.info",
      "pepe@fernandoguillen.info",
      "xxx@gmail.com"
    ].join(',')
    
    assert_equal( mails, VotationParser.extract_mails( tmail ) )
  end
  
  test "on parse_answer should create an Answer" do
    @question = Factory(:question)
    tmail = self.parse_mail( 'a_plus_one_vote' )
    
    VotationParser.expects(:exists_question?).with( tmail ).returns( @question ).once
    
    assert_difference "Answer.count", 1 do
      @answer = VotationParser.parse_answer( tmail )
    end
    
    assert_equal( '+1', @answer.vote )
    assert_equal( @question, @answer.question )
    assert_equal( "XXX@gmail.com", @answer.mail )
    assert_equal( tmail.subject, Marshal.load(@answer.raw_mail).subject )
    assert_equal( '2009-08-22 12:35:18', @answer.mail_date.to_s(:db) )
  end
  
  test "on parse_answer should NOT create an Answer if not Question found" do
    tmail = self.parse_mail( 'a_plus_one_vote' )
    
    assert_difference "Answer.count", 0 do
      VotationParser.parse_answer( tmail )
    end
  end
  
  test "on parse_answer should NOT create an Answer if not vote found" do
    @question = Factory(:question)
    tmail = self.parse_mail( 'simple_question' )
    VotationParser.expects(:exists_question?).with( tmail ).returns( @question ).once
    
    assert_difference "Answer.count", 0 do
      VotationParser.parse_answer( tmail )
    end
  end
  
  test "on parse should create a Question, an Answer and execute a command" do
    tmail = self.parse_mail( 'question_answer_and_command' )
    
    VotationCommand.expects(:results).once
    
    assert_difference "Question.count", 1 do
      assert_difference "Answer.count", 1 do
        VotationParser.parse( tmail )        
      end
    end
  end
  
  test "on parse_commands should execute results command" do
    @question = Factory(:question)
    tmail = self.parse_mail( 'command_results' )
    VotationParser.expects(:exists_question?).with( tmail ).returns( @question ).once
    VotationCommand.expects(:results).with(@question, 'XXX@gmail.com').once
    VotationParser.parse_commands( tmail )
  end
  
  test "on parse_commands should execute results web" do
    @question = Factory(:question)
    tmail = self.parse_mail( 'command_web' )
    VotationParser.expects(:exists_question?).with( tmail ).returns( @question ).once
    VotationCommand.expects(:web).with(@question, 'XXX@gmail.com').once
    VotationParser.parse_commands( tmail )
  end
  
  test "on parse_commands with upcase command should execute command" do
    @question = Factory(:question)
    tmail = TMail::Mail.new
    tmail.expects(:body).returns('::ReSulTs::').once
    tmail.expects(:from).returns(['xxx']).once
    VotationParser.expects(:exists_question?).with( tmail ).returns( @question ).once
    VotationCommand.expects(:results).once
    VotationParser.parse_commands( tmail )
  end
  
  test "on parse_commands with 'result' command should execute results command" do
    @question = Factory(:question)
    tmail = TMail::Mail.new
    tmail.expects(:body).returns('::result::').once
    tmail.expects(:from).returns(['xxx']).once
    VotationParser.expects(:exists_question?).with( tmail ).returns( @question ).once
    VotationCommand.expects(:results).once
    VotationParser.parse_commands( tmail )
  end
  
  test "on parse_commands with 'link' command should execute web command" do
    @question = Factory(:question)
    tmail = TMail::Mail.new
    tmail.expects(:body).returns('::link::').once
    tmail.expects(:from).returns(['xxx']).once
    VotationParser.expects(:exists_question?).with( tmail ).returns( @question ).once
    VotationCommand.expects(:web).once
    VotationParser.parse_commands( tmail )
  end
  
  test "on parse_commands should NOT execute results command if not any Question related found" do
    VotationCommand.expects(:results).never
    tmail = self.parse_mail( 'command_results' )
    VotationParser.parse_commands( tmail )
  end
  
  test "on parse_commands should NOT execute results command if not any command found" do
    VotationCommand.expects(:results).never
    tmail = self.parse_mail( 'simple_question' )
    VotationParser.parse_commands( tmail )
  end
  
  
  test "on parse_question the subject RE: should be deleted" do
    tmail = self.parse_mail( "with_re_before_subject" )
  
    assert_difference "Question.count", 1 do
      @question = VotationParser.parse_question( tmail )
    end
  
    assert_equal( "pregunta?", @question.subject )
  end
  
  # TODO
  test "on extract_mails remove duplicates" do
  end
  
  test "on parse_question should clean the body" do
    tmail = self.parse_mail( 'mail_with_html' )
    
    @question = VotationParser.parse_question( tmail )
    
    assert_match( "Este es realmente el body", @question.body )
    assert_match( /^XXX$/, @question.body )
    
    assert_no_match( /Content-Transfer-Encoding/, @question.body )
    assert_no_match( /word-wrap/, @question.body )
    assert_no_match( /Apple-Mail-1/, @question.body )    
  end
  
  test "on parse_answer should clean the body" do
    @question = Factory(:question)
    tmail = self.parse_mail( 'mail_with_html' )
    
    VotationParser.expects(:exists_question?).with( tmail ).returns( @question ).once
    VotationParser.expects(:extract_vote).with( tmail ).returns( '+1' ).once
        
    @answer = VotationParser.parse_answer( tmail )
    
    assert_match( "Este es realmente el body", @answer.body )
    assert_match( /^XXX$/, @answer.body )
    
    assert_no_match( /Content-Transfer-Encoding/, @answer.body )
    assert_no_match( /word-wrap/, @answer.body )
    assert_no_match( /Apple-Mail-1/, @answer.body )    
  end
  
  
  test "on remove_commands should remove the ::web:: command" do
    tmail = self.parse_mail( 'command_web' )
  
    assert_match( /::web::/, tmail.body )
    assert_match( "This is the body", VotationParser.remove_commands( tmail.body ) )
    assert_no_match( /::web::/, VotationParser.remove_commands( tmail.body ) )
  end
  
  test "on remove_commands should remove the ::results:: command" do
    tmail = self.parse_mail( 'command_results' )
        
    assert_match( /::results::/, tmail.body )
    assert_match( "This is the body", VotationParser.remove_commands( tmail.body ) )
    assert_no_match( /::results::/, VotationParser.remove_commands( tmail.body ) )
  end
  
  
  test "on remove_commands should remove any command" do
    tmail = TMail::Mail.new
    tmail.stubs(:body).returns("::wadus::  \n xxx")
        
    assert_match( /::wadus::/, tmail.body )
    assert_match( "xxx", VotationParser.remove_commands( tmail.body ) )
    assert_no_match( /::wadus::/, VotationParser.remove_commands( tmail.body ) )
  end
  
  test "on parse_question should remove the commands" do
    tmail = self.parse_mail( "command_results" )
  
    @question = VotationParser.parse_question( tmail )
  
    assert_match( "This is the body", @question.body )
    assert_no_match( /::results::/, @question.body )
  end
  
  
  test "on parse_answer should remove the commands" do
    @question = Factory(:question)
    tmail = self.parse_mail( 'command_results' )
    
    VotationParser.expects(:exists_question?).with( tmail ).returns( @question ).once
    VotationParser.expects(:extract_vote).with( tmail ).returns( '+1' ).once
        
    @answer = VotationParser.parse_answer( tmail )
    
    assert_match( "This is the body", @answer.body )
    assert_no_match( /::results::/, @answer.body )
  end
   
   test "get the name from the sender of an mail in the question" do
     tmail = self.parse_mail( "five_destinies" )
     VotationParser.parse( tmail )     
     assert_equal( "Fernando Guillen",  Question.first.owner_name)
   end
  
   test "get the name from the sender of an mail in the answer" do
     tmail = self.parse_mail( "a_minus_one_vote" )
     VotationParser.parse( tmail )     
     assert_equal( "Fernando Guillen",  Answer.first.name)
   end
   
   test "on this email should create a Question and an Answer" do
     tmail = self.parse_mail( "yahoo_forwaded_error" )
     
     assert_difference "Question.count", 1 do
       assert_difference "Answer.count", 1 do
         VotationParser.parse( tmail )
       end       
     end
     
     # puts Question.last.body
     # puts Answer.last.vote
     
   end
   
   
   def test_on_this_email_from_mailman_should_create_a_Question_well
     tmail = self.parse_mail( "question_mailman" )
     
     assert_difference "Question.count", 1 do
       VotationParser.parse( tmail )
     end
     
     assert_match(/kind of fancy python but/, Question.last.body)
     assert_no_match(/<div><br>/, Question.last.body)
     assert_no_match(/mailman\/listinfo\/python-list/, Question.last.body)
   end
   
   def test_on_parse_felipe_mail_with_firm_should_delete_firm
     tmail = self.parse_mail( "felipe_firm" )
     
     assert_difference "Question.count", 1 do
       VotationParser.parse( tmail )
     end
     
     # puts Question.last.body
          
     assert_match(/adsgasdfasdfa/, Question.last.body)
     assert_no_match(/Felipe Talavera/, Question.last.body)
   end

   # def test_on_parse_question_with_name_encoded_should_decoded_it
   #   tmail = self.parse_mail( "mail_encoding" )
   #   assert_difference "Question.count", 1 do
   #     VotationParser.parse( tmail )
   #   end
   #   
   #   puts "name: #{Question.last.owner_name}"
   #   puts "mail: #{Question.last.owner_mail}"
   #        
   #   assert_match(/adsgasdfasdfa/, Question.last.body)
   #   assert_no_match(/Felipe Talavera/, Question.last.body)
   # end
   
end