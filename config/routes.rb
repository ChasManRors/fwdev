Rails3BootstrapDeviseCancan::Application.routes.draw do
  get "static_pages/home"

  get "static_pages/help"

  get "static_pages/login_in"

  get "static_pages/about"

  get "static_pages/feed_back"

  get "raw_agents/index"

  get "raw_agents/show"

  get "raw_agents/new"

  get "raw_agents/edit"

  get "raw_agents/create"

  get "raw_agents/update"

  get "raw_agents/destroy"

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users, :only => [:show, :index]
end
