class FacebookPage
  
  ## includes ##
  include Mongoid::Document
  include Mongoid::Timestamps

  ## fields ##
  field :name, type: String
  field :access_token, type: String
  field :category, type: String
  field :fb_page_id, type: String
  field :perms, type: Array
  field :realtor_id, :type => BSON::ObjectId

  field :picture, type: String
  field :link, type: String
  field :likes, type: Integer
  field :is_published, type: Boolean
  field :website, type: String
  field :has_added_app, type: Boolean
  field :username, type: String
  field :founded, type: String
  field :description, type: String
  field :about, type: String
  field :release_date, type: String
  field :can_post, type: Boolean
  field :talking_about_count, type: Integer
  
  ## associations ##
  belongs_to :account
  belongs_to :realtor
  belongs_to :facebook_posts
  
  
  # attr_accessible :title, :content, :seo_meta_title, :seo_meta_keys, :seo_meta_desc, :published, :tags
  
  
  ## validations ##
  
  
  ## scopes ##
  scope :order_by_name, order_by(:name => :asc)
  
  ## callbacks ##
  
  
  ## methods ##
  
  
end