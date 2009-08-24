Factory.define :question do |f|
  f.sequence(:subject) { |n| "question_#{n}?" }
  f.body "This is a very cool t-shirt design I had done.\n\n
          http://www.flickr.com/photos/27620885@N02/2655218248/\n
          Enjoy my cousing model."
  f.mails "a@b.com,c@d.com,e@f.com"
  f.sequence(:qhash) { |n| "c9ad3e38b37cb2068a8a07f1279076aad8a4b0#{n}" }
  f.owner_name "Fernando Guillen"
  f.owner_mail "fguillen.mail@gmail.com"
  f.mail_date Time.now 
end

Factory.define :answer do |f|
  f.vote '+1'
  f.body "+1\n\n Vamos a por ello ahi!"
  f.association :question
  f.sequence(:mail) { |n| "email_#{n}@gmail.com" }
  f.sequence(:name) { |n| "name_#{n}" }
  f.mail_date Time.now
end
