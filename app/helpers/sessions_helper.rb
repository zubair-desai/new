module SessionsHelper


# =>  Desired authentication method is to place a 
# =>  (newly created) remember token as a cookie on the user’s browser, 
# =>  and then use the token to find the user record in the 
# =>  database as the user moves from page to page

  def sign_in(user)
    remember_token = User.new_remember_token  # => Create a new token (method is found in User model, hence "User".new_remember_token)
    cookies.permanent[:remember_token] = remember_token # => Place the enuncrypted token in the browser cookiee (special Rails cookies function)
    user.update_attribute(:remember_token, User.encrypt(remember_token)) # => Save encrypted token to the database in remember_token column
    self.current_user = user # => set current user equal to the given user
  end

  def signed_in?
    !current_user.nil?
  end


  def current_user=(user)
    @current_user = user
  end

  def current_user
  	# => Need to encrypt the token from the cookiee so that we can find it in the DB.
    remember_token = User.encrypt(cookies[:remember_token])

	# =>  Make current user = current user and/or corresponding token in DB.
    #What this says is: if I haven't looked up and set the 
    #instance variable @current_user yet, then look it up; 
    #if I have already set it, then just return it. That saves a lot of looking up.
    @current_user ||= User.find_by(remember_token: remember_token) 
  end


  def sign_out
    self.current_user = nil # => Not necessary because it redirects to destroy, but would be if it did not redirect. 
    cookies.delete(:remember_token)  
  end

end