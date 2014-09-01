require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Minibruno
  class Application < Rails::Application
    config.middleware.insert_after ActionDispatch::ParamsParser, ActionDispatch::XmlParamsParser
    config.i18n.default_locale = :es
    config.active_record.default_timezone = :local
    config.active_record.time_zone_aware_attributes = false
    config.to_prepare do
      Devise::SessionsController.layout 'session'
    end
  end
end