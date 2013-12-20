class SessionsController < ApplicationController

def new

end

def create
    user = User.find_by(email: params[:session][:email].downcase) #THIS VARIABLE IS USED EVERYWHERE
    if user && user.authenticate(params[:session][:password]) # => if correct User(email) AND correct password
      sign_in user  # =>  see sessions helper
      redirect_back_or user   #sessions helper method, sends user to intended page
    else
      flash.now[:error] = 'Invalid email/password combination' 
      render 'new'
    end
end

def destroy
	sign_out
	redirect_to root_url
end

end
