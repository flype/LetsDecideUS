Feature: Flickr Integration
	So that users can display images related to a question
	As a user
	I want the application to parse flickr urls
	

Scenario: Flickr Url
	Given that I start a question with the body 
				"""
				check out this photo!
			  http://www.flickr.com/photos/myudistira/2786115353/
			  """
	 When I go to the question's page
	 Then I should see the image "Sunrise Voyage por myudistira."
