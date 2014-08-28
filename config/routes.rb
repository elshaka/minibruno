Rails.application.routes.draw do
  root 'dashboard#index'

  devise_for :users

  resources :alarm_types

  resources :base_units

  resources :stat_types

  match 'stats' => 'stats#create', via: :post

  match 'stops' => 'stops#start', via: :post
  match 'stops' => 'stops#end', via: :put

  match 'reports' => 'reports#index', via: :get, as: 'reports'
end
