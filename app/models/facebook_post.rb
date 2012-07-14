class FacebookPost
  
  ## includes ##
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::MultiParameterAttributes

  ## fields ##
  field :message, type: String
  field :publish_on, type: DateTime, default: Time.now 
  field :published_on, type: DateTime
  field :published, type: Boolean, default: false



  
  
  ## associations ##
  belongs_to :account
  belongs_to :facebook_page
  # has_many :realtors
  # attr_accessible :title, :content, :seo_meta_title, :seo_meta_keys, :seo_meta_desc, :published, :tags
  
  
  ## validations ##
  
  
  ## scopes ##
  
  
  ## callbacks ##
  
  
  ## methods ##
  
  
end