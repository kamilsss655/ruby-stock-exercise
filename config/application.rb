require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Wallet
  class Application < Rails::Application
    # Configure application as API
    config.api_only = true
    # Keep default debug information format
    config.debug_exception_response_format = :default
  end
end
