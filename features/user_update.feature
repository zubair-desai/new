Feature: Edit Page

Scenario: User enters valid information
	Given a user visits the edit page
	When they enter valid information
	And they click Save changes
	Then they should see a success message

Scenario: User enters invalid information
	Given a user visits the edit page
	When they enter invalid information
	And they click Save changes
	Then they should see an error



