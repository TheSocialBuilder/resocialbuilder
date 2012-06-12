class MlsMarket
  
  
  ## includes ##
  include Mongoid::Document
  include Mongoid::Timestamps

  
  
  ## fields ##
  field :title, type: String
  field :login_url, type: String
  field :username, type: String
  field :password, type: String
  field :search_fields, type: Array
  field :meta_data, type: Hash
  
  
  ## associations ##
  # belongs_to :account
  has_many :agents
  has_many :listings
  has_many :offices
  
  ## validations ##
  
  
  ## scopes ##
  
  
  ## callbacks ##
  
  
  ## methods ##
  
  
end