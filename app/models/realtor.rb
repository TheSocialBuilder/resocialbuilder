class Realtor
  
  
  ## includes ##
  include Mongoid::Document
  include Mongoid::Timestamps
  
  
  ## fields ##
  field :account_id, type: String
  field :first_name, type: String
  field :last_name, type: String
  field :mls_agent_id, type: String
  field :email, type: String
  field :password, type: String
  field :phone, type: String
  field :time_zone, type: String, default: 'Mountain Time (US & Canada)'
  
  mount_uploader :avatar, MediaUploader
  
  
  ## associations ##
  belongs_to :account
  
  
  ## validations ##
  
  
  ## scopes ##
  
  
  ## callbacks ##
  
  
  ## methods ##
  
  
end