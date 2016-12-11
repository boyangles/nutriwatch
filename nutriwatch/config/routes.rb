Rails.application.routes.draw do
  get 'homepage/index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'homepage#index'
  get '/signup', to: 'users#new'
  get '/form', to: 'homepage#form'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  get "dishes/query" => "dishes#query", as: :dishes_query

  resources :dishes do
    collection do
      get 'query'
    end
  end
  
  resources :restaurants #Restful routes for RestaurantsController
  resources :restaurantmenus #Restful routes for RestaurantmenusController
  resources :restaurantcuisines #REST routes for RestaurantcuisinesController
  resources :ingredients #Restful routes for IngredientsController
  resources :dishes #Restful routes for DishesController
  resources :dishingredients #Restful routes for DishingredientsController
  resources :dietaryviolations #Restful routes for DietaryViolationsController 
  resources :users



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
