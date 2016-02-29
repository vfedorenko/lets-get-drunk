json.(event, :id, :title, :description, :image_url, :description, :updated_at)
json.creator event.creator, partial: 'users/user', as: :user
json.users event.users, partial: 'users/user', as: :user