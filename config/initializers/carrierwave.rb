# config/initializers/carrierwave.rb
CarrierWave.configure do |config|
  if Rails.env.production?
      config.fog_credentials = {
        :provider               => 'AWS',
        :aws_access_key_id      => ENV["AWS_ACCESS_KEY"],
        :aws_secret_access_key  => ENV["AWS_SECRET_KEY"],
        :region  => ENV["AWS_REGION"]
      }
      config.fog_directory  = ENV["AWS_BUCKET"]
      config.fog_public     = false                                        # optional, defaults to true
      config.fog_attributes = {'Cache-Control'=>"max-age=#{365.day.to_i}"} # optional, defaults to {}
      config.storage = :fog
  else
    config.storage = :file
    config.root = "#{Rails.root}/public/"
  end
end