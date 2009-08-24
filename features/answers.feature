# Feature: Answers	
# 	Scenario Outline: Voting
# 	
# 	Given that we have the question "Do we go to war with Irak?"
# 	 When I send the following email:
# 		    | from                    | to                  | subject                    | body                |
# 		    | rumbler@railsrumble.com | hello@letsdecide.us | Do we go to war with Irak? | <body>							 |
# 
# 	 Then we will have the following question:
# 			 | title                      | in_favor   | against   |
# 			 | Do we go to war with Irak? | <in_favor> | <against> |
# 
# 	Examples:
# 			 | body                | in_favor | against |
# 			 | fuck that shit\n -1 | 0        | 1       |
# 			 | destruction!\n +1   | 1        | 0       |