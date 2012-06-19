class Page
  
  
  ## includes ##
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  # include Mongoid::Versioning
  include Mongoid::Tree
  include Mongoid::Tree::Ordering
  include Mongoid::Tree::Traversal
  include Mongoid::TaggableWithContext
  
  
  ## fields ##
  field :title, type: String
  slug :title, history: true
  field :content, type: String
  field :seo_meta_title, type: String
  field :seo_meta_keys, type: String
  field :seo_meta_desc, type: String
  field :published, type: Boolean, default: true
  taggable :tags, :separator => ','
  
  
  ## associations ##
  belongs_to :account
  
  attr_accessible :title, :content, :seo_meta_title, :seo_meta_keys, :seo_meta_desc, :published, :parent_id
  
  
  ## validations ##
  
  
  ## scopes ##
  
  
  ## callbacks ##
  
  
  ## methods ##
  
  
end