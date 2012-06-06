Rails.application.config.middleware.use OmniAuth::Builder do
  
	provider :facebook, "208065319210030", "e5af6b7b10b9ccaf3e6a589f82002c18", {:scope => 'email, offline_access, manage_pages, publish_stream, publish_actions'}

end