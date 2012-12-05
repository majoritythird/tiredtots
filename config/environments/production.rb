Sleepmonster::Application.configure do
  config.cache_classes = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  config.serve_static_assets = true
  config.static_cache_control = "public, max-age=3600"
  # If we're precompiling, we want to compress assets.
  # If not, we don't want to turn on compress because it will try to load gems
  # we don't have in production.
  config.assets.compress = "#{ENV['RAILS_GROUPS']}".index('assets')
  # Generate digests for assets URLs
  config.assets.digest = true
  config.action_dispatch.x_sendfile_header = "X-Sendfile"
  config.serve_static_assets = false
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  config.action_mailer.default_url_options = { :host => 'sleepmonster.com' }
end
