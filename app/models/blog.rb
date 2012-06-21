class Blog
  
  
  ## includes ##
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  # include Mongoid::Versioning
  include Mongoid::TaggableOn
  
  
  ## fields ##
  field :title, type: String
  slug :title, history: true
  field :content, type: String
  field :seo_meta_title, type: String
  field :seo_meta_keys, type: String
  field :seo_meta_desc, type: String
  field :published, type: Boolean, default: true
  taggable_on :tags
  
  
  ## associations ##
  belongs_to :account
  
  attr_accessible :title, :content, :seo_meta_title, :seo_meta_keys, :seo_meta_desc, :published, :tags
  
  
  ## validations ##
  
  
  ## scopes ##
  
  
  ## callbacks ##
  
  
  ## methods ##
  
  
end