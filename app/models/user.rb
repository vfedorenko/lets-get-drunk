require 'gcm'

class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable

  include DeviseTokenAuth::Concerns::User

  has_many :friends, through: :friendships

  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "to_id"
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  has_many :events_users
  has_many :events, through: :events_users

  def json_response
    as_json(only: [:id, :name, :email, :image])
  end

  def to_push
    as_json(only: [:id, :name, :image])
  end

  def send_friend_push(type, user)
    p "device id of #{self.name} = #{self.device_id}"
    unless self.device_id.nil?
      p "sending push to #{self.name}"

      build_gcm

      @options = {data: {user: user, type: type}}
      @response = @gcm.send([self.device_id], @options)
    end
  end

  def send_event_push(type, user, event_name)
    p "device id of #{self.name} = #{self.device_id}"
    unless self.device_id.nil?
      p "sending push to #{self.name}"

      build_gcm

      @options = {data: {user: user, event_name: event_name, type: type}}
      @response = @gcm.send([self.device_id], @options)
    end
  end

  private

  def build_gcm
    @gcm = GCM.new("AIzaSyB8mr0HidwIUbqr92OW4n5imTBnMwbguZE")
  end
end