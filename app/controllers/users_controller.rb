class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @pending_request = current_user.pending_friends
    @received_requests = current_user.friend_requests
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end

  def confirm_request
    current_user.confirm_friend(params[:friend])
  end

  private

  def friend_params
    params.permit(:friend)
  end
end
