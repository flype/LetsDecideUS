class AddMailDateToQuestion < ActiveRecord::Migration
  def self.up
    add_column :questions, :mail_date, :datetime
    
    Question.all.each { |e| e.update_attribute(:mail_date, e.created_at) }
  end

  def self.down
    remove_column :questions, :mail_date
  end
end
