class Blog
  
  
  ## includes ##
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  # include Mongoid::Versioning
  
  
  ## fields ##
  field :title, type: String
  slug :title, history: true
  field :content, type: String
  field :seo_meta_title, type: String
  field :seo_meta_keys, type: String
  field :seo_meta_desc, type: String
  field :published, type: Boolean, default: true
  
  
  ## associations ##
  belongs_to :account
  
  ## validations ##
  
  
  ## scopes ##
  
  
  ## callbacks ##
  
  
  ## methods ##
  
  
end