module ApplicationHelper
  def menu_link_to(link_text, link_path)
    class_name = current_page?(link_path) ? 'menu-item active' : 'menu-item'

    content_tag(:div, class: class_name) do
      link_to link_text, link_path
    end
  end

  def like_or_dislike_btn(post)
    like = Like.find_by(post: post, user: current_user)
    if like
      link_to('Dislike!', post_like_path(id: like.id, post_id: post.id), method: :delete)
    else
      link_to('Like!', post_likes_path(post_id: post.id), method: :post)
    end
  end

  def friend_request_btn(user)
    return '' if user.eql? current_user
    if @pending_request.include? user
      'pending invitation'
    elsif !current_user.friend?(user) and !@received_requests.include? user
      link_to('Invite', user_friendships_path(friend_id: user.id, user_id: current_user.id), method: :post)
    elsif current_user.friend?(user)
      'you both are friends'
    else
      "#{user.name} sent you a friend request"
    end
  end

  def confirm_btn(user)
    link_to('Accept', accept_request_path(friend_id: user.id, user_id: current_user.id), method: :put)
  end

  def reject_btn(user)
    
  end

  # def confirm_btn(user)
  #   if @received_requests.include? user
  #     link_to('Accept', accept_request_path(friend_id: user.id), method: :patch)
  #   end
  # end
end
