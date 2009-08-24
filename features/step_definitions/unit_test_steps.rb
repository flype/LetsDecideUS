Given /^that I call the method "([^\"]*)" of the class "([^\"]*)" with the (?:url|parameter) "([^\"]*)"$/ do |method, class_name, argument|
  #class_name.constantize.send(method, argument)
  LetsDecide::GoogleMap.new(argument)
end


