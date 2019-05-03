require 'fog/aws'
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
if Rails.env.production?
     CarrierWave.configure do |config|
        config.storage = :fog
        config.fog_credentials = {
             :provider => "AWS",
             :aws_access_key_id => Rails.application.credentials[:DO_ACCESS_KEY_ID] ,
             :aws_secret_access_key => Rails.application.credentials[:DO_SECRET_ACCESS_KEY],
             :region => Rails.application.credentials[:DO_REGION],
             :endpoint => Rails.application.credentials[:DO_ENDPOINT_URL],
             :path_style => true
        }
        config.fog_directory=Rails.application.credentials[:DO_BUCKET]
        config.fog_attributes={'Cache-Control'=>'max-age=315576000'}
	config.fog_public=false
        config.asset_host=Rails.application.credentials[:DO_ENDPOINT_URL]
        config.fog_attributes={ 'Cache-Control' => 'max-age=315576000' }
     end 
end
