# == Schema Information
# Schema version: 20090822110546
#
# Table name: answers
#
#  id          :integer(4)      not null, primary key
#  body        :text
#  raw_mail    :text
#  vote        :string(255)
#  mail        :string(255)
#  name        :string(255)
#  question_id :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#

class Answer < ActiveRecord::Base
  belongs_to :question

  named_scope :plus, :conditions => { :vote => '+1' }
  named_scope :minus, :conditions => { :vote => '-1' }
  named_scope :order_asc, :order => "mail_date ASC"
  named_scope :order_desc, :order => "mail_date DESC"

  def has_expired?
    !self.question.answers_without_duplicated.include?(self)
  end
  
  def plus?
    self.vote == "+1"
  end
  
  def minus?
    self.vote == "-1"    
  end
end
