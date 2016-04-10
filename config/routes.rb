Rails.application.routes.draw do

  root 'home#index'
  
	get 'search' => 'search#index'
  
  # Routes that require authentication, redirected to devise
	authenticate :user do

  	resources :relations, only: [:create, :destroy]

  	resources :posts, only: [:create, :destroy]

	# route without argument of id for reading notifications of relations
  	patch "relations" => "relations#update"

  end

  devise_for :users

  get '(:username)' => 'home#index', as: 'user_timeline'

end
