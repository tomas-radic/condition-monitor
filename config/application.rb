require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ConditionMonitor
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
		config.i18n.default_locale = :sk
		config.api_measurements_timeout = 10 # defines minimum number of minutes to pass since latest saved measurement to accept & save any new ones
    config.time_zone = 'Bratislava'
    config.phase_measurements_display_limit = 300
  end
end
