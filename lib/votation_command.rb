class VotationCommand
  def self.results( question, requested_by )
    RAILS_DEFAULT_LOGGER.info( "(#{Time.now().to_s(:db)}) VotationCommand: command 'results' invoqued for question '#{question.subject}' by '#{requested_by}'" )
    
    BotMailer.deliver_results( question, requested_by )
  end
  
  def self.web( question, requested_by )
    RAILS_DEFAULT_LOGGER.info( "(#{Time.now().to_s(:db)}) VotationCommand: command 'web' invoqued for question '#{question.subject}' by '#{requested_by}'" )

    BotMailer.deliver_web( question, requested_by )
  end
end