require 'spec_helper'

describe "StaticPages" do
subject { page }

  describe "Home Page" do
	  	before { visit "/static_pages/home" }
	  	it { should have_content('Sample App') }
	  	it { should have_title("Ruby on Rails Sample App | Home")}
  end
    
  describe "Help Page" do
	  	before { visit "/static_pages/help" }
	  	it { should have_content('Help') }
	  	it { should have_title("Ruby on Rails Sample App | Help")}
  end

  describe "About Page" do
		before { visit "/static_pages/about" }
		it { should have_content("About") }
		it { should have_title("Ruby on Rails Sample App | About")}
  end	



end




