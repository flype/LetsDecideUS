class BotMailer < ActionMailer::Base
  helper :application

  def results(question, requested_by, sent_at = Time.now)
    subject    "Re: #{question.subject}"
    recipients question.mails.to_a
    from       CONFIG[:bot_mail]
    sent_on    sent_at
    
    body       :question => question,
               :requested_by => requested_by
  end

  def web(question, requested_by, sent_at = Time.now)
    subject    "Re: #{question.subject}"
    recipients question.mails.to_a
    from       CONFIG[:bot_mail]
    sent_on    sent_at
    
    body       :question => question,
               :requested_by => requested_by
  end
  
  def exception(exception, sent_at = Time.now)
    subject    "LetsDecideUs EXCEPTION: #{exception.message}"
    recipients CONFIG[:admin_mails].split(',')
    from       CONFIG[:bot_mail]
    sent_on    sent_at
    
    body       :exception => exception
  end

end
