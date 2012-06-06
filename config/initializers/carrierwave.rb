CarrierWave.configure do |config|
  config.storage = :fog
  config.fog_credentials = {
    :provider           => 'Rackspace',
    :rackspace_username => 'bhammond',
    :rackspace_api_key  => '850842e4a357f1a0f8bdc312c32922d7'
  }
  config.fog_directory = 'resb_mls_listings'
  config.fog_host = "http://c15062414.r14.cf2.rackcdn.com"
end