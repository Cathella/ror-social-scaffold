class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id], confirmed: false)
    if @friendship.save
      redirect_to users_path, notice: 'friend request sent.'
    else
      redirect_to posts_path, alert: 'You cannot send this user a friend request.'
    end
  end

  # def destroy
  #  friendship = Friendship.find_by(id: params[:id], user_id: current_user.id, friend_id: params[:friend_id])
  #  if like
  #    like.destroy
  #    redirect_to posts_path, notice: 'You disliked a post.'
  #  else
  #    redirect_to posts_path, alert: 'You cannot dislike post that you did not like before.'
  #  end
  # end

  private

  def friendship_params
    params.require(:friendship).permit(:friend_id)
  end
end
