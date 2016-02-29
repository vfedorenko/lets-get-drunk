class Event < ActiveRecord::Base
  has_many :events_users
  has_many :users, through: :events_users
  belongs_to :creator, class_name: "User"
  validates :title, presence: true, length: { minimum: 3 }
  validates :description, presence: true, length: { minimum: 5 }
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)\Z}i,
    message: 'URL has to be for image'
  }
end
