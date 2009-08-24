Given /^that I start a question with the body$/ do |body|
  @question = Factory(:question, :body => body)
end

Then /^I should see a google map$/ do
  response.body.should have_tag("#google_map")
end
