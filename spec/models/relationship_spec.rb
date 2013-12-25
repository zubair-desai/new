require 'spec_helper'

describe Relationship do

  	let(:follower) { FactoryGirl.create(:user) }
  	let(:followed) { FactoryGirl.create(:user) }
	let(:relationship) { follower.relationships.build(followed_id: followed.id)} # build the followed-id field for follower

	subject { relationship } #as oppposed to using @instance variable in user_spec, this comes out from let(:relationship) in line above.

	it { should be_valid}

	describe "accessible attributes" do
		it { should_not allow_mass_assignment_of(:followe_id) } 
	end

	describe "follower methods" do

		it { should respond_to(:follower)}
		it { should respond_to(:followed)}
		its(:follower) { should == follower}
		its(:followed) { should == followed}
	end

	describe "when follower is not present" do  #User model-level test
		before { relationship.follower_id = nil }
		it { should_not be_valid }
	end

	describe "when followed is not present" do #User model-level test
		before { relationship.followed_id = nil }
		it { should_not be_valid }
	end



end
