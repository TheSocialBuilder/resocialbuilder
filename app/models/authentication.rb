class Authentication
	include Mongoid::Document
	
	field :uid
	field :provider
	field :credentials, type: Hash
	field :extra, type: Hash
	field :info, type: Hash

	embedded_in :authorized, polymorphic: true
end