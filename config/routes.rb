Rails.application.routes.draw do
	resources :all_reports, only: [:index]
	resources :user_groups, except: [:show]
	resources :projects, except: [:show]
	resources :users, except: [:show]
	resources :user_settings, only: [:edit, :update]
	resources :sessions, only: [:new, :create, :destroy]
	resources :week_reports, except: [:show]

	root 'week_reports#index'
	match '/signin',  to: 'sessions#new',				via: 'get'
	match '/signout', to: 'sessions#destroy',			via: 'delete'
	match '/change_week',  to: 'week_reports#change_week',		via: 'get'
	match '/copy_item',  to: 'week_reports#copy_item',		via: 'get'
	match '/search_week_or_month',  to: 'all_reports#search_week_or_month',		via: 'post'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
