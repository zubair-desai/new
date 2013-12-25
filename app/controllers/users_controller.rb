class UsersController < ApplicationController

  # => Must Sign in before you can visit page Edit or use Update action 
  before_action :signed_in_user, only: [:edit, :update, :index, :destroy, :following, :followers]  # => special signed_in_user method is created below
  before_action :correct_user,   only: [:edit, :update] # => Also eliminates the need for edit method code
  before_action :admin_user,     only: :destroy

  def index
    @users = User.paginate(page: params[:page])# => (...,  per_page: 10)
  end

  def show
  	@user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page], per_page: 10)
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params) 
  	if @user.save
      sign_in @user
  		flash[:success] = "Welcome to the Sample App!"
  		redirect_to @user
  	else 
  		render 'new'
  	end
  end

  def edit
    # => Do not need this code here, due to before filter (correct_user) : originially @user = User.find(params[:id])
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers   
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end


private

	def user_params # =>  INSTEAD OF User.new(params[:user]), allows only certain params to go through
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end

  #Before Filters

  def correct_user 
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

end
