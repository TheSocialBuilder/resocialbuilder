class Blog
  
  
  ## includes ##
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  # include Mongoid::Versioning
  include Mongoid::TaggableOn
  
  
  
  ## fields ##
  field :title, type: String
  field :views, type: Integer, default: 0
  slug :title, history: true
  field :content, type: String
  field :seo_meta_title, type: String
  field :seo_meta_keys, type: String
  field :seo_meta_desc, type: String
  field :published, type: Boolean, default: true
  taggable_on :tags

  field :impressions, type: Integer
  index({ impressions: 1 }, { unique: true, background: true })
  
  
  ## associations ##
  belongs_to :account
  has_many :comments, as: :commentable
  
  attr_accessible :title, :content, :seo_meta_title, :seo_meta_keys, :seo_meta_desc, :published, :tags, :impressions
  
  
  ## validations ##
  validates_presence_of :title
  
  ## scopes ##
  
  
  ## callbacks ##
  
  
  ## methods ##
  def hit
    self.inc(:impressions, 1)
  end
  
  
end