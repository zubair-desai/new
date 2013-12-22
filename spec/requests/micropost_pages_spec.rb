require 'spec_helper'

describe "Micropost pages" do

	subject { page }

	let(:user) {FactoryGirl.create(:user)}

	before { sign_in user }

# => Here we want to 1. sign in a user, 2. Click on Post...
# => 3. If there's not valid information, 4. It should not...
# => Change the #of Microposts in the Database, and should...
# => 5. Have an error.  

#partial: 

	describe "micropost creation" do
		before { visit root_path}

		describe "with invalid information" do

			it "should not create a micropost" do
				expect { click_button "Post"}.not_to change(Micropost, :count)
			end

			describe "error messages" do
				before { click_button "Post"}
				it { should have_content("error")} 
			end
		end
	end

	describe "micropost destruction" do 
		before { FactoryGirl.create(:micropost, user: user )}

		describe "as correct user" do
			before { visit root_path}

			it "should delete a micropost" do 
				expect { click_link "delete"}.should change(Micropost, :count).by(-1)
			end
		end
	end
end
