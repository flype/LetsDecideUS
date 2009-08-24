Feature: Google Map Integration
	So that users can display maps related to a question
	As a user
	I want the application to parse a google maps url
	

Scenario: Google Map Url
	Given that I start a question with the body 
				"""
				Hey!
			  http://maps.google.com/maps?f=q&source=s_q&hl=en&geocode=&q=lao+lounge,+palma+de+mallorca&sll=39.568646,2.650452&sspn=0.690217,1.448822&g=Palma+de+Mallorca,+Spain&ie=UTF8&ll=39.532909,2.730103&spn=0.166023,0.362206&t=h&z=12&iwloc=A
				
				what you think yo!?
			  """
	 When I go to the question's page
	 Then I should see a google map
	