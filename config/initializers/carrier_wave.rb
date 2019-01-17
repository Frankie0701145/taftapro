# if Rails.env.production?
# 	CarrierWave.configure do |config|
# 		config.fog_credentials = {
# 		# Configuration for Google Cloud Storage
# 		:provider => 'Google',
# 		:google_storage_access_key_id => ENV['GOOGLE_STORAGE_ACCESS_KEY_ID'],
# 		:google_storage_access_key => ENV['GOOGLE_STORAGE_ACCESS_KEY']
# 		}
# 		config.fog_directory = ENV['GOOGLE_STORAGE_BUCKET']
# 	end
# end