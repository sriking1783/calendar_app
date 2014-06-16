json.array!(@calendar_settings) do |calendar_setting|
  json.extract! calendar_setting, :id, :default_view, :popup_time
  json.url calendar_setting_url(calendar_setting, format: :json)
end
