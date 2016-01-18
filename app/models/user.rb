class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable
  include DeviseTokenAuth::Concerns::User
  
  has_and_belongs_to_many :events
  
  def json_response
    as_json(only: [:id, :name, :email, :image])
  end
end
