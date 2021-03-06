class UsersController < ApplicationController
  before_action :logged_in_user, only: [:following, :followers]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @entries = @user.entries.paginate(page: params[:page])
      if logged_in?
        @comment = current_user.comments.build
      end
    redirect_to root_url and return unless true
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Blog System Requirements!"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

	# Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

	# Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

end
