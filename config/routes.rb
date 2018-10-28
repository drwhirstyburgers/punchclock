Rails.application.routes.draw do
  resources :teachers, only: [:new, :create] do
    resources :shifts
  end

  match "teachers/:teacher_id/shifts/new" => "shifts#create", :as => "clock_in", via: [:get, :post]

  match "teachers/:teacher_id/shifts/:id" => "shifts#update", :as => "clock_out", via: [:get, :patch, :put]

  resources :sessions, only: [:new, :create, :destroy]

  get 'welcome/index'

  get 'welcome/about'

  root 'welcome#index'
end
