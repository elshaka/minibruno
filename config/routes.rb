Rails.application.routes.draw do
  resources :motors

  root 'dashboard#index'
  get 'dashboard/stats', to: 'dashboard#stats'

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
  post 'motor_stats', to: 'motor_stats#create_multiple'

  get 'reports', to: 'reports#index'
  post 'reports/temperatures', to: 'reports#temperatures', as: 'temperatures_report'
  post 'reports/variable', to: 'reports#variable', as: 'variable_report'
  post 'reports/metering_bin', to: 'reports#metering_bin', as: 'metering_bin_report'
  post 'reports/discharges_and_temperatures', to: 'reports#discharges_and_temperatures', as: 'discharges_and_temperatures_report'
  post 'reports/pumped_fat', to: 'reports#pumped_fat', as: 'pumped_fat_report'
end
