class UsersController < ApplicationController
  before_filter :load_user,      :only => [:show, :update, :edit, :destroy]
  before_filter :signed_in_user, :only => [:show, :edit, :update]
  before_filter :correct_user,   :only=> [:edit, :update]

  def index
  	@users = User.all
  end

  def show
  end

  def edit
  end

  def update
  	 if @user.update_attributes(user_params)
  	 	redirect_to user_path(@user), :notice => "Your 
      account was successfully updated!"
  	 else
  	 	render 'edit'
      flash.now[:alert] = "Your account was not updated!"
  	 end
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      session[:user_id] = @user.id
  		redirect_to user_path(@user), :notice => "Your account 
      was successfully created!"
  	else
  		render 'new'
      flash.now[:alert] = "Your account was not created"
  	end
  end

  def destroy
  	 @user.destroy
  	 redirect_to users_url, :notice => "Your account was 
     successfully deleted!" 
  end

  def user_params
  	params.require(:user).permit(:username, :email,
  	:password, :password_confirmation, :picture,
  	:country, :state, :city, :biography)
  end

  def load_user
    @user = User.find(params[:id])
  end

  def signed_in_user
    unless signed_in? 
      redirect_to signin_path, :notice => "Please sign in"
    end
  end

  def correct_user
    if current_user != @user
      redirect_to users_url
    end
  end

end
