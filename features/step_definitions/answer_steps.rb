Given /^the following answers:$/ do |table|
  table.hashes.each do |hash|
    Factory(:answer, hash.merge(:question => @question, :mail => "me#{rand(100)}@rumbling.com"))
  end
end

Given /^that we have (\d) votes from a single email address$/ do |num|
  num.to_i.times do 
    Factory(:answer, :question => @question, :mail => "eva@gmail.com")
  end
end

When /^I send the following email:$/ do |table|
  pending
end

Then /^there should be (\d) answers by now$/ do |num|
  response.should have_tag("#answers_by_now", num)
end

Then /^the number of votes in favor will be (\d)$/ do |num|
  response.should have_tag(".vote.lcol", :count => num.to_i)
end

Then /^the number of votes against will be (\d)$/ do |num|
  response.should have_tag(".vote.rcol", :count => num.to_i)
end

Then /^I will see the following answers:$/ do |table|
  table.hashes.each do |hash|
    response.should have_tag(".author", hash['author'])
    response.should have_tag(".vote-content", /#{hash['body']}/)
  end
end

Then /^the first 4 answers will have the class "([^\"]*)"$/ do |class_name|
  Answer.order_desc[0..3].each do |answer|
    response.should have_tag("#answer_#{answer.id}") do
      with_tag(".novalid")
    end
  end
end

Then /^the last answers will not have the class "([^\"]*)"$/ do |class_name|
  valid_answer = Answer.last
  response.should have_tag("#answer_#{valid_answer.id}") do
    without_tag(".novalid")
  end
end

