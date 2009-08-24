Given /^there are no questions$/ do
  Question.delete_all
end

Given /^that we have a question$/ do
  @question = Factory(:question)
end

Given /^that we have the question "([^\"]*)"$/ do |title|
  Question.create!(:title => title)
end

Given /^we have the following question:$/ do |table|
  @question = Factory(:question, table.hashes.first)
end

Given /^the question body "(.*)"$/ do |body|
  @question.update_attributes(:body => body)
end

Then /^we will have the following question:$/ do |table|
  resource = Question.last
  table.hashes.each do |hash|
    hash.each do |attribute, value|
      resource.send(attribute).to_s.should == (value.nil? ? "" : value)
    end
  end 
end





