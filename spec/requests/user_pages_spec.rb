require 'spec_helper'

describe "User Pages" do
	subject { page }

	describe "Sign up page" do
		before { visit signup_path }

		it { should have_title(full_title("Sign Up"))}
		it { should have_content('Sign Up') } 
	end

end
