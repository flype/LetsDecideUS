class VotationParser
  
  def self.parse( tmail )
    RAILS_DEFAULT_LOGGER.info( "(#{Time.now().to_s(:db)}) VotationParser: parsing email" )

    # should I parse it?
    return  unless self.should_i_put_attention?( tmail )
    
    # is a new question?
    self.parse_question( tmail )
    
    # is a votation?
    self.parse_answer( tmail )
    
    # parser the commands
    self.parse_commands( tmail )
  end
  
  #
  # looks into the subject looking for a ? at the end
  #
  def self.should_i_put_attention?( tmail )
    !(tmail.subject_clean_up =~ /\?\s*$/).nil? and tmail.from.first != CONFIG[:bot_mail]
  end
  
  #
  # looks if the mail is indeed a new question
  # if it is: create a new question
  #TODO: contemplar el caso de los mails cuando son a un grupo a una lista de correo
  def self.parse_question(tmail)
    unless self.exists_question?( tmail )
      question = 
        Question.create!( 
          :subject      => tmail.subject_without_re, 
          :body         => self.remove_commands(tmail.body_clean_up), 
          :mails        => self.extract_mails(tmail), 
          :raw_mail     => Marshal.dump(tmail),
          :qhash        => self.create_qhash( tmail ),
          :owner_mail   => tmail.from.first,
          :owner_name   => tmail.from_addrs.first.name,
          :mail_date    => tmail.date
        )
      
      RAILS_DEFAULT_LOGGER.info( "(#{Time.now().to_s(:db)}) VotationParser: Question created '#{question.subject}'" )
      
      return question  
    end
    return nil
  end  
  #
  # looks if the mail is indeed an answer with a vote
  # if it is: create a new answer
  #
  # returns the created Answer
  # or nil if not any Answer created
  #
  def self.parse_answer(tmail)
    if question = self.exists_question?( tmail )
      if vote = self.extract_vote( tmail )
        answer = 
          Answer.create!( 
            :question => question,
            :vote     => vote,
            :body     => self.remove_commands(tmail.body_clean_up),
            :mail     => tmail.from.first,
            :raw_mail => Marshal.dump(tmail),
            :name     => tmail.from_addrs.first.name,
            :mail_date => tmail.date
          )
        
        RAILS_DEFAULT_LOGGER.info( "(#{Time.now().to_s(:db)}) VotationParser: Answer create '#{answer.vote}' for Question '#{question.subject}'" )
      
        return answer
      end
    end
    
    return nil
  end
  
  
  # 
  # Create tha hash and look for another question with this
  # hash, if not any found then returns nil
  # otherwise returns the Question found
  #
  def self.exists_question?(tmail)
    Question.find_by_qhash( self.create_qhash( tmail ) )
  end
  
  #
  # Looks into the body for a valid vote
  # returns nil if not any found
  #
  def self.extract_vote( tmail )
    votes = tmail.body.scan( /^\s*([+-]1)\s*$/ ).flatten
    
    return votes.first  if !votes.empty?
    return nil
  end
  
  # 
  # looks into the body for commands
  # dispath to the VotationCommands class if any found
  #
  # if not any question associated not any command executed
  #
  def self.parse_commands( tmail )
    @question = self.exists_question?( tmail )
    return  unless @question
    
    commands = tmail.body.scan( /^\s*::(.*)::\s*$/ ).flatten
    requested_by = tmail.from.first
    
    commands.each do |command|
      case command
        when /^(results|result)$/i then VotationCommand.results( @question, requested_by )
        when /^(web|link)$/i then VotationCommand.web( @question, requested_by )
        else RAILS_DEFAULT_LOGGER.info( "Bad command: #{command}" )
      end
    end
  end
  
  #
  # extract all the emails invited on a Question
  # if is only one we supposse we are sending to a mail list
  #
  def self.extract_mails( tmail )
    emails = []
    
    emails += tmail.cc  if tmail.cc
    emails += tmail.to  if tmail.to

    emails.delete(CONFIG[:bot_mail])
    
    emails += tmail.from  unless emails.size == 1
    
    emails.sort!
    emails = emails.join(',')
    
    return emails
  end
  
  def self.create_qhash( tmail )
    mails = self.extract_mails( tmail )
    Digest::SHA1.hexdigest("#{mails} #{tmail.subject_clean_up}")
  end
  
  def self.remove_commands( body )
    body.gsub( /^\s*::.*::\s*$/, '' )
  end  
end