Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  root "static_pages#home"
  get "help" => "static_pages#help"
  get "contact" => "static_pages#contact"

  devise_for :users, skip: :sessions
  as :user do
    get "login" => "devise/sessions#new", as: :new_user_session
    post "login" => "devise/sessions#create", as: :user_session
    delete "logout" => "devise/sessions#destroy", as: :destroy_user_session
  end

  namespace :admin do
    root "countries#new"
    resources :countries, only: [:new, :create]
    resources :leagues, except: [:edit, :update]
    resources :news, except: :show
    resources :news_types, except: :show
    resources :teams, only: [:new, :create, :show]
  end
end
