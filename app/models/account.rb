class Account
  
  
  ## includes ##
  include Mongoid::Document
  include Mongoid::Timestamps
  
  
  ## fields ##
  field :first_name, type: String
  field :last_name, type: String
  field :name, type: String
  field :email, type: String
  field :phone, type: String
  field :subdomain, type: String
  
  # Facebook Omniauth Fields
  field :fb_id, type: String
	field :fb_info, type: Hash
	field :fb_token, type: String
	field :fb_token_expiration, type: DateTime
	field :fb_image, type: String
  
  
  field :settings_site_title, type: String
  field :settings_search_min, type: String
  field :settings_search_max, type: String
  field :settings_google_analytics, type: String
  field :settings_featured_listings, type: Array
  
  field :settings_social_facebook, type: String
  field :settings_social_twitter, type: String
  field :settings_social_linkedin, type: String
  field :settings_social_youtube, type: String
  

  field :template, type: String, default: 'template_1'
  field :time_zone, type: String, default: 'Mountain Time (US & Canada)'
  field :internal_agent_nrds_id, type: String
  

  
  
  mount_uploader :logo, MediaUploader
  mount_uploader :avatar, MediaUploader
  
  ## associations ##
  # has_one :agent
  has_many :transactions, dependent: :delete
  has_many :cards, dependent: :delete
  has_many :pages, dependent: :delete
  has_many :blogs, dependent: :delete
  has_many :facebook_pages, dependent: :delete
  has_many :facebook_posts, dependent: :delete
  belongs_to :mls_market
  embeds_one :location, as: :locatable, :cascade_callbacks => true, :autobuild => true
  embeds_many :emails
  
  
  attr_accessible :first_name, :last_name, :name, :email, :phone, :subdomain, :internal_agent_nrds_id, :logo, :avatar
  attr_accessible :settings_site_title, :settings_search_min, :settings_search_max, :settings_google_analytics, :settings_featured_listings
  attr_accessible :settings_social_facebook, :settings_social_twitter, :settings_social_linkedin, :settings_social_youtube
  attr_accessible :fb_id, :fb_info, :fb_token, :fb_token_expiration, :fb_image
  attr_accessible :cards_attributes, :location_attributes, :emails_attributes

  accepts_nested_attributes_for :cards, :location

  
  
  ## validations ##
  
  
  ## scopes ##
  
  
  ## callbacks ##
  before_save :format_phone
  
  ## methods ##

  def self.from_omniauth(omniauth)
    
    where(fb_id: omniauth.uid).find_or_initialize_by do |account|
      
      account.first_name = omniauth.info.first_name
      account.last_name = omniauth.info.last_name
      account.email = omniauth.info.email
    
      account.fb_id = omniauth.uid
      account.fb_info = omniauth.info
      account.fb_token = omniauth.credentials.token
      account.fb_token_expiration = Time.at(omniauth.credentials.expires_at)
      account.fb_image = omniauth.info.image
      
      account.save!
      
      
      @facebook = Koala::Facebook::GraphAPI.new(account.fb_token)
      
      @facebook_pages = @facebook.get_connections("me", "accounts")
      # raise @facebook_pages.to_yaml
    
      if @facebook_pages
        
        @facebook_pages.each do |fb_page|
          #raise fb_page.to_yaml
          if fb_page['category'] != 'Application'
            page_graph = Koala::Facebook::GraphAPI.new(fb_page['access_token'])
            page = page_graph.get_object("me")
            # raise page.to_yaml

            facebook_page = account.facebook_pages.new
      

            facebook_page.name = fb_page['name']
            facebook_page.access_token = fb_page['access_token']
            facebook_page.category = fb_page['category']
            facebook_page.fb_page_id = fb_page['id']
            facebook_page.perms = fb_page['perms'] if fb_page['perms']
        
            facebook_page.picture = page['picture']
            facebook_page.link = page['link']
            facebook_page.likes = page['likes']
            facebook_page.is_published = page['is_published']
            facebook_page.website = page['website']
            facebook_page.has_added_app = page['has_added_app']
            facebook_page.username = page['username']
            facebook_page.founded = page['founded']
            facebook_page.description = page['description']
            facebook_page.about = page['about']
            facebook_page.release_date = page['release_date']
            facebook_page.can_post = page['can_post']
            facebook_page.talking_about_count = page['talking_about_count']
      
            facebook_page.save
          end
      
        end
      end
      
      
      
    end
  end

  def facebook
    @facebook ||= Koala::Facebook::GraphAPI.new(self.fb_token) if self.fb_token
  end
  
  # Clean up the phone and format it correctly
  def format_phone
    if Phoner::Phone.valid? self.phone
      pn = Phoner::Phone.parse phone, :country_code => '1'
      self.phone = pn.format("(%a) %f-%l")
    end
  end
  
  # Format the users full name
  def name
    "#{self.first_name} #{self.last_name}"
  end

end
