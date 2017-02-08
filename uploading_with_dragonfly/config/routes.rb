Rails.application.routes.draw do
  resources :albums do
    resources :songs, only: [:new, :create]
  end

  root to: 'albums#index'
end
