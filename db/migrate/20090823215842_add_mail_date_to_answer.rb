class AddMailDateToAnswer < ActiveRecord::Migration
  def self.up
    add_column :answers, :mail_date, :datetime
    
    Answer.all.each { |e| e.update_attribute(:mail_date, e.created_at) }
  end

  def self.down
    remove_column :answers, :mail_date
  end
end
