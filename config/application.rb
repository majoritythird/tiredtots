require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env) if defined?(Bundler)

module Sleepmonster
  class Application < Rails::Application
    config.time_zone = "UTC"

    config.action_view.javascript_expansions[:defaults] = %w()

    config.encoding = "utf-8"

    config.filter_parameters += [:password]

    config.active_support.escape_html_entities_in_json = true

    config.active_record.schema_format = :sql

    if config.respond_to?(:sass)
      config.sass.load_paths << Rails.root.join('vendor/assets/stylesheets')
    end

    config.generators do |g|
      g.test_framework :rspec, :views => false, :fixture => true
      g.integration_tool :rspec
      g.fixture_replacement :fabrication
    end

    config.assets.initialize_on_precompile = false

    config.assets.enabled = true

    config.assets.version = '1.0'
  end
end
