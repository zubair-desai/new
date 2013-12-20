require 'spec_helper'

describe User do
  before { @user = User.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")}
  subject { @user }

  it { should respond_to(:name)}
  it { should respond_to(:email)}
  it { should respond_to(:password_digest)}
  it { should respond_to(:password)}
  it { should respond_to(:password_confirmation)}  #not a db column
  it { should respond_to(:authenticate)} #not a db column
  it { should respond_to(:remember_token) } 
  it { should respond_to(:admin) }
  it { should_not be_admin }
  it { should be_valid }
	  
	describe "with admin attribute set to 'true'" do
	    before do
	      @user.save!
	      @user.toggle!(:admin) #makes false to true
	    end
		it { should be_admin }
	end

	describe "when name is not present" do
	  	before { @user.name = " " }
	  	it { should_not be_valid}
	end

	describe "when email is not present" do
	  	before { @user.email = " "}
	  	it { should_not be_valid}
	end

	describe "when the name is too long" do
	  	before { @user.name = "a"*51 }
	  	it { should_not be_valid}
	end

	describe "when email format is invalid" do
		it "should be invalid" do
			addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
			addresses.each do |bad_address|
				@user.email = bad_address
				expect(@user).not_to be_valid
			end
		end
	end

	describe "when email format is valid" do
		it "should be valid" do
			addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
			addresses.each do |good_address|
				@user.email = good_address
				expect(@user).to be_valid
			end
		end
	end

	describe "when an email address is already taken" do
		before do
			user_with_same_email = @user.dup
			user_with_same_email.email = @user.email.upcase
			user_with_same_email.save
		end
		it { should_not be_valid}
	end

	describe "when password is blank" do
		before { @user = User.new(name: "Example User", email: "user@example.com", password: " ", password_confirmation: " ")}

		it {should be_invalid}
	end

	describe "when password is mismatched" do
		before { @user.password_confirmation = "mismatch" }

		it {should be_invalid}
	end

	describe "when the password is too short" do
		before { @user.password = @user.password_confirmation = "a" * 5}
		it {should_not be_valid }
	end
	
	describe "when return value of authenticate method is provided" do # => Chapter 6 - What to do if the password matches or mismatches
		before { @user.save } # => Saves to database so User can be retrieved

		let(:found_user) { User.find_by(email: @user.email) } # => - "let" retrieves User with Find By.  

		describe "with valid password" do # => Password Matches between @user and found_user
			it {should eq found_user.authenticate(@user.password)}
		end

		describe "with invalid password" do # => Password Mismatch between @user and user_for_invalid_password (remember before @user stated at start of this doc.)
			let(:user_for_invalid_password) { found_user.authenticate("invalid")}

			it { should_not eq user_for_invalid_password }
			specify { expect(user_for_invalid_password).to be_false }
		end
	end

	describe "remember token" do
	    before { @user.save }
	    its(:remember_token) { should_not be_blank }   # =>  its is an attribute of an it, in this case @user
  	end
end
