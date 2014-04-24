EmberNote::Application.routes.draw do

  get "file/policy"
  get "file/upload"

  devise_for :users, :controllers => {
    :sessions => 'users/sessions',
    :omniauth_callbacks => "users/omniauth_callbacks"
  }

  devise_scope :user do
    get 'sign_in', :to => 'users/sessions#new'
    get 'sign_out', :to => 'users/sessions#destroy'
  end

  resources :tags

  get "home/index"
  get 'login' => "login#index"

  resources :notes do
    collection do
      get 'search'
    end
    resources :note_attachments
  end

  root to: "home#index"
end
