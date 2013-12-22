require 'spec_helper'

describe Micropost do
	let(:user) { FactoryGirl.create(:user) }

	before do 
		@micropost = user.microposts.build(content:"Lorem ipsum")	  
	end

	subject { @micropost }

	it { should respond_to(:content) }
	it { should respond_to(:user_id) }

	# => "belongs_to :user" in micropost.rb resolves the test below 
	it { should respond_to(:user) }
	its(:user) { should == user }

	it { should be_valid }

	describe "accessible attributes" do
		it { should_not allow_mass_assignment_of(:user_id) } 
	end

	describe "accessible attributes that are allowed" do # => uses shoulda gem
		it { should allow_mass_assignment_of(:content) } 
	end


	describe "when user_id is not present" do
		before { @micropost.user_id = nil }
		it { should_not be_valid }
	end 

	describe "with blank content" do
		before { @micropost.content = " "}
		it {should_not be_valid}
	end

	describe "with content that is too long" do
		before { @micropost.content = "a" *141 }
		it { should_not be_valid }
	end

end
