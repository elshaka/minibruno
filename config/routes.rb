Rails.application.routes.draw do
  root 'dashboard#index'

  devise_for :users
  devise_scope :user do
    resources :users
    get 'user_settings', to: 'users#settings', as: 'user_settings'
    post 'user_settings', to: 'users#update_settings'
  end

  resources :alarm_types, :base_units, :stat_types, :turns, except: :show

  post 'stats', to: 'stats#create'
  post 'stats/multiple', to: 'stats#create_multiple'
  post 'alarms', to: 'alarms#create'
  post 'stops', to: 'stops#start'
  put 'stops', to: 'stops#end'

  get 'reports', to: 'reports#index'
  post 'reports/temperatures', to: 'reports#temperatures', as: 'temperatures_report'
  post 'reports/variable', to: 'reports#variable', as: 'variable_report'
end
