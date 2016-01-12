Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
	# Api definition
  namespace :api, defaults: { format: :json } do
    # We are going to list our resources here
    resources :events
  end
end
