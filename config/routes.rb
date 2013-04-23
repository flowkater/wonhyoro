require 'api_constraints'
# http://railscasts.com/episodes/350-rest-api-versioning?view=asciicast

Wonhyoro::Application.routes.draw do
  
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  scope "/admindnjsgyfh1rk13ektl25" do
    # skip 회원가입 x
    devise_for :users, skip: [:registrations], path_names: { sign_in: 'login' }
  end

  # namespace :api, defaults: {format: 'json'} do
  #   scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
  #     resources :posters
  #   end
  # end

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :events

      match "/init", to: "main#init", via: :get
    end
  end

  match "/dashboard", to: "main#dashboard"

  resources :events do
    resources :pictures
    resources :teasers
    resources :attendships
  end

  resources :teasers do
    member do
      put 'push'
    end
    resources :pictures
    resources :movies
  end

  resources :notis do
    member do
      put 'push'
    end
  end  

  root to: "main#dashboard"


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
