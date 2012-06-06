Paperclip::Attachment.default_options.update({
  :path => ":id/:attachment/:style/image_:fingerprint",
  :storage => :fog,
  :fog_credentials => {
    :provider           => 'Rackspace',
    :rackspace_username => 'bhammond',
    :rackspace_api_key  => '850842e4a357f1a0f8bdc312c32922d7',
    :persistent => false
  },
  :fog_directory => 'resb_mls_listings',
  :fog_public => true,
  :fog_host => 'http://c15062414.r14.cf2.rackcdn.com'
})