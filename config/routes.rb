Rails.application.routes.draw do
  resources :teachers, only: [:new, :create] do
    resources :shifts
  end

  resources :sessions, only: [:new, :create, :destroy]

  get 'welcome/index'

  get 'welcome/about'

  root 'welcome#index'
end
