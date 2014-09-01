Rails.application.routes.draw do
  root 'dashboard#index'

  devise_for :users
  devise_scope :user do
    resources :users
  end

  resources :alarm_types, :base_units, :stat_types, except: :show

  post 'stats', to: 'stats#create'
  post 'alarms', to: 'alarms#create'
  post 'stops', to: 'stops#start'
  put 'stops', to: 'stops#end'

  get 'reports', to: 'reports#index'
  post 'reports/test', to: 'reports#test', as: 'test_report'
end