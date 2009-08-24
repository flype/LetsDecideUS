ActionMailer::Base.smtp_settings = {
  :address        => CONFIG[:bot_mail_server],
  :port           => 25,
  :domain         => CONFIG[:bot_mail_domain],
  :authentication => :login,
  :user_name      => CONFIG[:bot_mail],
  :password       => CONFIG[:bot_mail_pass]
}