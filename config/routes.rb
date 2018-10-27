Rails.application.routes.draw do
  resources :teachers, only: [:new, :create]
  
  get 'welcome/index'

  get 'welcome/about'

  root 'welcome#index'
end
