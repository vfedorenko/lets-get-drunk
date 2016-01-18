class Event < ActiveRecord::Base
    has_and_belongs_to_many :users
  validates :title, presence: true, length: { minimum: 3 }
  validates :description, presence: true, length: { minimum: 5 }
end