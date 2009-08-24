class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.string  :subject
      t.text    :body
      t.text    :raw_mail
      t.string  :qhash
      t.text    :mails
      t.string  :owner_mail
      t.string  :owner_name
      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end
