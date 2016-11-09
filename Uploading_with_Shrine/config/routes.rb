Rails.application.routes.draw do
  resources :photos, only: [:new, :create, :index, :edit, :update]

  root 'photos#index'
end