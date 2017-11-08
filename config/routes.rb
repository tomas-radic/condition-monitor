Rails.application.routes.draw do

  scope '(:locale)', locale: /sk|en/ do
	  devise_for :users, controllers: { registrations: 'registrations' }

	  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	  
	  get 'home/index'
	  root to: 'products#index'
	  get 'users/password_change', to: 'users#password_change', as: 'password_change'
	  patch 'users/password_change_confirm', to: 'users#password_change_confirm', as: 'password_change_confirm'
	  
    resources :products do
      resources :phases
    end

    resources :measurements
	end
end
