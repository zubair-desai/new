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

	  	describe "for signed-in users" do
	  		let(:user) { FactoryGirl.create(:user)}
	  		before do 
	  			FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
	  			FactoryGirl.create(:micropost, user: user, content: "Dolor sit am")
	  			sign_in user
	  			visit root_path
	  		end
	  		it "should render the user's feed" do
	  			user.feed.each do |item|
	  				page.should have_selector("li##{item.id}", text: item.content)
	  			end
	  		end
	  		# => CHAPTER 11
	  		describe "follower/following counts" do
	  			let(:other_user) {FactoryGirl.create(:user)}
	  			before do
	  				other_user.follow!(user)
	  				visit root_path
	  			end
		  		it { should have_link("0 following", href: following_user_path(user))}
		  		it { should have_link("1 follower", href: followers_user_path(user))}
	  		end
	  	end
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







