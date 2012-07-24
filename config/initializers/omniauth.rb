Rails.application.config.middleware.use OmniAuth::Builder do
  
	provider :facebook, ENV["FACEBOOK_APP_ID"], ENV["FACEBOOK_APP_SECRET"], {:scope => 'email, offline_access, manage_pages, publish_stream, publish_actions'}

end