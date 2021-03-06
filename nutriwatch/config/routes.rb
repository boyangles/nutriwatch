Rails.application.routes.draw do
  get 'sessions/new'

  get 'homepage/index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'homepage#index'

  get '/form', to: 'homepage#form'
  post '/form', to: 'homepage#filter'

  get 'dishes/query', to: "dishes#query", as: :dishes_query
  resources :dishes do
    collection do
      get 'query'
    end
  end

  get 'users/signup', to: 'users#new'
  post 'users/signup',  to: 'users#create'

  get    '/filter',   to: 'homepage#new'
  post   '/filter',   to: 'homepage#create'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  get '/logout',  to: 'sessions#destroy'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products


  
  resources :restaurants #Restful routes for RestaurantsController
  resources :restaurantmenus #Restful routes for RestaurantmenusController
  resources :restaurantcuisines #REST routes for RestaurantcuisinesController
  resources :ingredients #Restful routes for IngredientsController
  resources :dishes #Restful routes for DishesController
  resources :dishingredients #Restful routes for DishingredientsController
  resources :dietaryviolations #Restful routes for DietaryViolationsController 
  resources :homepage
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
