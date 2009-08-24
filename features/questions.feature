#@webrat
#Feature: Questions
#	Scenario: Create a new question
#	
#	Given there are no questions
#	 When I send the following email:
#		    | to                  | subject                    |
#		    | hello@letsdecide.us | Do we go to war with Irak? |
#	
#	 Then we will have the following question
#			  | title                      |
#			  | Do we go to war with Irak? |
				
Scenario: Results
		 
		Given we have the following question:
				  | subject                    | owner_name     | 
				  | Do we go to war with Irak? | Raimond Garcia | 
				
		  And the question body "http://maps.google.com/maps?f=q&source=s_q&hl=en&geocode=&q=es+trenc,+palma+de+mallorca&sll=37.0625,-95.677068&sspn=45.149289,92.724609&ie=UTF8&ll=39.466945,2.832413&spn=0.332362,0.724411&t=h&z=11&iwloc=C"
				
		  And the following answers:
				  | name             | body      | vote |
				  | Carlos Matallin  | No way    | -1   |
				  | Fernando Guillen | No thanks | -1   |
				  | Felipe Talavera  | WTF       | -1   |
				  | Raimond Garcia   | Nop       | -1   |
				  | George Bush      | Yehaa     | +1   |

		 When I go to the question's page
		 Then I should see "Do we go to war with Irak?"
		  And I should see "Asked by Raimond Garcia"
		  And there should be 5 answers by now
		  And the number of votes in favor will be 1
		  And the number of votes against will be 4
		  And I will see the following answers:
		 		  | author           | body      |
		 		  | Carlos Matallin  | No way    |
		 		  | Fernando Guillen | No thanks |
		 		  | Felipe Talavera  | WTF       |
		 		  | Raimond Garcia   | Nop       |
		 		  | George Bush      | Yehaa     |

		 #warning if the question has already been answered.
		
Scenario: Non valid votes
	  Given that we have a question
	    And that we have 5 votes from a single email address
	   When I go to the question's page
	   Then the first 4 answers will have the class "non-valid"
	    And the last answers will not have the class "non-valid"
	   