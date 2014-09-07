class Settings < Settingslogic
  source ENV.fetch('TURBOBIL_CONFIG') { "#{Rails.root}/config/turbobil.yml" }
  namespace Rails.env

end


Settings['turbobil'] ||= Settingslogic.new({})
Settings.turbobil['dir_sips']  = "#{Rails.root}/config/sips/"
