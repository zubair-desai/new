Feature: Signing in

Scenario: Unsuccessful signin
	Given a user visits the signin page
	When they submit invalid signin information
	Then they should see an error

Scenario: Successful signin
	Given a user visits the signin page
	And the user has an account
	When they submit valid signin information
	Then they should see their profile page
	And they should see a signout link


Scenario: Signing out
	Given a user visits the signin page
	And the user has an account
	And they submit valid signin information
	When they click the signout link
	Then they should see a signin link
