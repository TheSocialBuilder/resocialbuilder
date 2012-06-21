class Account
  
  
  ## includes ##
  include Mongoid::Document
  include Mongoid::Timestamps
  
  
  ## fields ##
  field :title, type: String
  field :site_title, type: String
  field :subdomain, type: String
  field :time_zone, type: String, default: 'Mountain Time (US & Canada)'
  field :settings_search_min, type: String
  field :settings_search_max, type: String
  field :mls_office_id, type: String
  
  mount_uploader :logo, MediaUploader
  
  ## associations ##
  has_many :realtors, dependent: :delete
  has_many :transactions, dependent: :delete
  has_many :cards, dependent: :delete
  has_many :pages, dependent: :delete
  has_many :blogs, dependent: :delete
  belongs_to :mls_market
  
  attr_accessible :cards_attributes, :realtors_attributes, :subdomain

  accepts_nested_attributes_for :cards, :realtors

  
  
  ## validations ##
  
  
  ## scopes ##
  
  
  ## callbacks ##
  
  
  ## methods ##
  
  
end
