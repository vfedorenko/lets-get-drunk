class FriendsController < ApplicationController
  before_action :authenticate_user!

  def index
    @show_status = true

    @to_me_accepted = User.joins('LEFT OUTER JOIN friendships ON friendships.from_id = users.id').where("friendships.to_id=? AND friendships.accepted=?", current_user.id, true)
    @from_me_accepted = User.joins('LEFT OUTER JOIN friendships ON friendships.to_id = users.id').where("friendships.from_id=? AND friendships.accepted=?", current_user.id, true)

    @friends = @to_me_accepted + @from_me_accepted

    @friends.each do |f|
      f.status = 3
    end

    @to_me = User.joins('LEFT OUTER JOIN friendships ON friendships.from_id = users.id').where("friendships.to_id=? AND friendships.accepted=?", current_user.id, false)

    @to_me.each do |f|
      f.status = 1
    end

    @from_me = User.joins('LEFT OUTER JOIN friendships ON friendships.to_id = users.id').where("friendships.from_id=? AND friendships.accepted=?", current_user.id, false)

    @from_me.each do |f|
      f.status = 2
    end

    @users = @friends + @to_me + @from_me
  end

  def friend_request
    from_id = current_user.id
    to_id = params[:id] # this is the id of the user you want to become friend with

    @user = User.where(id: to_id).first

    if @user.nil?
      render status: 404
      return
    end

    @friendships = Friendship.where("to_id=? AND from_id=? OR to_id=? AND from_id=?", to_id, from_id, from_id, to_id).all

    if @friendships.size > 0
      render json: {
          status: ErrorCodes::ALREADY_EXISTS
      }, status: 422

      return
    end

    if Friendship.create(from_id: from_id, to_id: to_id, accepted: false)
      @user.send_friend_push(PushTypes::FRIEND_REQUEST, current_user.to_push)
      render status: 200
    else
      render status: 400
    end
  end

  def friend_accept
    # accepting a friend request is done by the recipient of the friend request.
    # thus the current user is identified by to_id.

    friendable = Friendship.where(to_id: current_user.id, from_id: params[:id]).first
    friendable.update_attributes(accepted: true)

    @user = User.where(id: params[:id]).first
    @user.send_friend_push(PushTypes::FRIEND_ACCEPTED, current_user.to_push)
  end

  def friend_reject
    friendable = Friendship.where(to_id: current_user.id, from_id: params[:id]).first
    friendable.destroy

    @user = User.where(id: params[:id]).first
    @user.send_friend_push(PushTypes::FRIEND_DECLINED, current_user.to_push)
  end
end
