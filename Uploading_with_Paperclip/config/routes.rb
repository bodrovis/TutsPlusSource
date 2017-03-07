Rails.application.routes.draw do
  resources :books do
    member do
      get 'download'
    end
  end
  root to: 'books#index'
end
