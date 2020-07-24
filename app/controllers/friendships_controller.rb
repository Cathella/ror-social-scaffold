class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    if @friendship.save
      redirect_to users_path, notice: 'friend request sent.'
    else
      redirect_to posts_path, alert: 'You cannot send this user a friend request.'
    end
  end

  def accept
    friend = User.find(params[:friend_id])
    current_user.confirm_friend(friend)
    @friendship = current_user.friendships.build(friend_id: friend.id, confirmed: true)
    if @friendship.save
      redirect_to users_path, notice: 'friend request accepted.'
    else
      redirect_to posts_path, alert: "You cannot accept this user's friend request."
    end
  end

  # def accept
  #   friend = User.find(params[:friend_id])
  #   current_user.confirm_friend(friend)
  #   redirect_to users_path, notice: 'friend request accepted.'
  # end

  def destroy
    friendship = Friendship.find(params[:id])
    # friend = params[:friend_id]
    # user = params[:user_id]
    # friendship = Friendship.where(user_id: user, friend_id: friend)
    # friendship = Friendship.find_by(id: params[:id], user_id: current_user.id, friend_id: params[:friend_id])
    if friendship
      friendship.destroy
      redirect_to users_path, notice: "friend request rejected"
    else
      redirect_to users_path, alert: "could not reject request, try again"
    end
  end

  private

  def friendship_params
    params.require(:friendship).permit(:friend_id)
  end
end
