# Be sure to restart your server when you modify this file.

Rails.application.configure do
  config.lograge.enabled = ENV.fetch("LOGRAGE_ENABLED", "true") == "true"

  config.lograge.custom_payload do |controller|
    extra_payload = {}
    extra_payload[:user_id] = controller.current_user&.id
    extra_payload
  end
end
