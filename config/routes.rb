EmberNote::Application.routes.draw do
  get 'tags' => 'tags#index'
  get "home/index"
  resources :notes
  root to: "home#index"
end
