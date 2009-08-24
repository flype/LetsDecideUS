# == Schema Information
# Schema version: 20090822110546
#
# Table name: questions
#
#  id         :integer(4)      not null, primary key
#  subject    :string(255)
#  body       :text
#  raw_mail   :text
#  qhash      :string(255)
#  mails      :text
#  owner_mail :string(255)
#  owner_name :string(255)
#  created_at :datetime
#  updated_at :datetime
#


class Question < ActiveRecord::Base
  has_many :answers
    
  def answers_without_duplicated
    b = Hash.new
    self.answers.order_asc.each {|a| b[ a.mail ] = a  }
    return b.values.flatten
  end
  
  def plus_counter_without_duplicated
    self.answers_without_duplicated.delete_if{ |e| e.vote != '+1' }.size
  end
  
  def minus_counter_without_duplicated
    self.answers_without_duplicated.delete_if{ |e| e.vote != '-1' }.size
  end
  
  def plus_counter_with_duplicated
    self.answers.order_asc.delete_if{ |e| e.vote != '+1' }.size
  end
  
  def minus_counter_with_duplicated
    self.answers.order_asc.delete_if{ |e| e.vote != '-1' }.size
  end
  
  def votation_result
    result = plus_counter_without_duplicated - minus_counter_without_duplicated
    return "DEUCE" if result == 0
    result > 0 ? "YES" : "NO"
  end
end
