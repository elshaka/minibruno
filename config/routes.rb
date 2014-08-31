Rails.application.routes.draw do
  root 'dashboard#index'

  devise_for :users

  resources :alarm_types, except: :show

  resources :base_units, except: :show

  resources :stat_types, except: :show

  match 'stats' => 'stats#create', via: :post

  match 'alarms' => 'alarms#create', via: :post

  match 'stops' => 'stops#start', via: :post
  match 'stops' => 'stops#end', via: :put

  # Reports
  get 'reports', to: 'reports#index'
  post 'reports/test', to: 'reports#test', as: 'test_report'
end