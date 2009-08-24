Then /^I should see the image "([^\"]*)"$/ do |filename|
  response.should have_tag("img[alt=#{filename}]")
end
