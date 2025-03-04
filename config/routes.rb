Rails.application.routes.draw do
  # Routes for the Like resource:
  # devise_for :users
  devise_for :users, path: '', path_names: { sign_in: 'users/sign_in', sign_out: 'users/sign_out', sign_up: 'users/sign_up', edit: 'users/edit' }

# Custom user routes to use username instead of ID
resources :users, param: :username, only: [:show] do
  member do
    get 'feed'
    get 'discover'
    get 'liked_photos'
  end
end

  get("/users", { :controller => "users", :action => "index" })
  get("/users/:username", { :controller => "users", :action => "show" })
  get("/users/:username/feed", { :controller => "users", :action => "feed" })
  get("/users/:username/discover", { :controller => "users", :action => "discover" })
  get("/users/:username/liked_photos", { :controller => "users", :action => "liked_photos" })


  # CREATE
  post("/insert_like", { :controller => "likes", :action => "create" })
          
  # READ
  get("/likes", { :controller => "likes", :action => "index" })
  
  get("/likes/:path_id", { :controller => "likes", :action => "show" })
  
  # UPDATE
  
  post("/modify_like/:path_id", { :controller => "likes", :action => "update" })
  
  # DELETE
  # get("/delete_like/:path_id", { :controller => "likes", :action => "destroy" })
  delete "/delete_like/:path_id", to: "likes#destroy", as: :delete_like


  #------------------------------

  # Routes for the Follow request resource:

  resources :follow_requests, only: [:index, :create, :destroy] do
    member do
      patch :accept
      patch :reject
    end
  end

  # CREATE
  post("/insert_follow_request", { :controller => "follow_requests", :action => "create" })
          
  # READ
  get("/follow_requests", { :controller => "follow_requests", :action => "index" })
  
  get("/follow_requests/:path_id", { :controller => "follow_requests", :action => "show" })
  
  # UPDATE
  
  post("/modify_follow_request/:path_id", { :controller => "follow_requests", :action => "update" })
  
  # DELETE
  get("/delete_follow_request/:path_id", { :controller => "follow_requests", :action => "destroy" })

  #------------------------------

  # Routes for the Comment resource:

  # CREATE
  post("/insert_comment", { :controller => "comments", :action => "create" })
          
  # READ
  get("/comments", { :controller => "comments", :action => "index" })
  
  get("/comments/:path_id", { :controller => "comments", :action => "show" })
  
  # UPDATE
  
  post("/modify_comment/:path_id", { :controller => "comments", :action => "update" })
  
  # DELETE
  get("/delete_comment/:path_id", { :controller => "comments", :action => "destroy" })

  #------------------------------

  # Routes for the Photo resource:

  # CREATE
  post("/insert_photo", { :controller => "photos", :action => "create" })
          
  # READ
  get("/photos", { :controller => "photos", :action => "index" })
  
  get("/photos/:path_id", { :controller => "photos", :action => "show" })
  
  # UPDATE
  
  post("/modify_photo/:path_id", { :controller => "photos", :action => "update" })
  
  # DELETE
  get("/delete_photo/:path_id", { :controller => "photos", :action => "destroy" })

  #------------------------------


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "users#index"
end
