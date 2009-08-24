require 'test_helper'

class TmailMonkeyPatchTest < ActiveSupport::TestCase
  test "on subject_without_re should return the subject without the re" do
    tmail = TMail::Mail.new
    tmail.expects(:subject).returns( ' re:  wadus? ' )
    
    assert_equal( 'wadus?', tmail.subject_without_re )
  end
  
  test "on subject_without_re should return the subject without the Re" do
    tmail = TMail::Mail.new
    tmail.expects(:subject).returns( 'Re: wadus?' )
    
    assert_equal( 'wadus?', tmail.subject_without_re )
  end
  
  # test "on subject_without_re should return the subject without [listname]" do
  #   tmail = TMail::Mail.new
  #   tmail.expects(:subject).returns( '[listname]Re: wadus?' )
  #   
  #   assert_equal( 'wadus?', tmail.subject_without_re )
  # end
  
  test "on body_clean_up with mail_with_firm should clean the text" do
    tmail = self.parse_mail( 'mail_with_firm' )
    
    assert_match( "este es el body", tmail.body_clean_up )
    assert_no_match( /Desarrollador Web Freelance/, tmail.body_clean_up )
  end

  test "on body_clean_up with mail mail_with_firm_and_quotes should clean the text" do
    tmail = self.parse_mail( 'mail_with_firm_and_quotes' )
    
    assert_match( "ni lo miro que no veo nada ya", tmail.body_clean_up )
    assert_match( /^-1$/, tmail.body_clean_up )
    
    assert_no_match( /Has recibido este mensaje porque/, tmail.body_clean_up )
    assert_no_match( /Talavera/, tmail.body_clean_up )
    assert_no_match( /Desarrollador Web Freelance/, tmail.body_clean_up )
  end
  
  test "on body_clean_up with mail mail_with_html should clean the text" do
    tmail = self.parse_mail( 'mail_with_html' )
    
    assert_match( "Este es realmente el body", tmail.body_clean_up )
    assert_match( /^XXX$/, tmail.body_clean_up )
    
    assert_no_match( /Content-Transfer-Encoding/, tmail.body_clean_up )
    assert_no_match( /word-wrap/, tmail.body_clean_up )
    assert_no_match( /Apple-Mail-1/, tmail.body_clean_up )
  end
  
  
  
  test "on body_clean_up with mail mail_with_image should clean the text" do
    tmail = self.parse_mail( 'mail_with_image' )
    
    assert_match( "este es el body", tmail.body_clean_up )
    
    assert_no_match( /Apple-Mail-3/, tmail.body_clean_up )
    assert_no_match( /4AAQSkZJRgABAgAAZABkAAD/, tmail.body_clean_up )
  end
  
  test "on body_clean_up with mail mail_with_googlegroups_firm should clean the text" do
    tmail = self.parse_mail( 'mail_with_googlegroups_firm' )
    
    assert_match( /^YYY$/, tmail.body_clean_up )
    assert_match( /^XXX$/, tmail.body_clean_up )
    
    assert_no_match( /Has recibido este mensaje/, tmail.body_clean_up )
  end
  
  # def test_wadus
  #   tmail = self.parse_mail( 'mail_with_html' )
  #   
  # end
  
  test "on subject_clean_up should return the subject without the Re, downcase and without space" do
    tmail = TMail::Mail.new
    tmail.expects(:subject).returns( 'Re: Wadus a Tope ?' )
    
    assert_equal( 'wadusatope?', tmail.subject_clean_up )
  end

end