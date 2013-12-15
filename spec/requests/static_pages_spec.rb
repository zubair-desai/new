# => HEROKU TROUBLESHOOTING: http://stackoverflow.com/questions/12206779/git-push-heroku-master-permission-denied-publickey-fatal-the-remote-end-hung

require 'spec_helper'

describe "StaticPages" do
	subject { page }

  	describe "Home Page" do
	  	before { visit root_path }
	  	it { should have_content('Sample App') }
	  	it { should have_title("Ruby on Rails Sample App")}
	  	it { should_not have_title("| Home")}
	  	it { should have_link('Sign up now', signup_path)}
  	end
    
  	describe "Help Page" do
	  	before { visit help_path }
	  	it { should have_content('Help') }
	  	it { should have_title("Ruby on Rails Sample App | Help")}
  	end

  	describe "About Page" do
		before { visit about_path }
		it { should have_content("About") }
		it { should have_title("Ruby on Rails Sample App | About")}
  	end	

  	describe "Contact Page" do
	  	before { visit contact_path }
	  	it { should have_content("Contact")}
	  	it { should have_title("Ruby on Rails Sample App | Contact")}
  	end

end







