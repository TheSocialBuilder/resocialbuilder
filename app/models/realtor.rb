class Realtor
  
  
  ## includes ##
  include Mongoid::Document
  include Mongoid::Timestamps
  include Streama::Actor
  
  
  ## fields ##
  field :first_name, type: String
  field :last_name, type: String
  field :email, type: String
  field :password, type: String
  field :phone, type: String
  field :time_zone, type: String, default: 'Mountain Time (US & Canada)'
  
  mount_uploader :avatar, MediaUploader
  
  
  ## associations ##
  belongs_to :account
  embeds_many :authentications, as: :authorized
  has_many :facebook_pages
  has_many :facebook_posts
  
  
  ## validations ##
  
  
  ## scopes ##
  
  
  ## callbacks ##
  
  
  ## methods ##
  def apply_omniauth(omniauth)
    self.email = omniauth['user_info']['email'] if email.blank?
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'], :info => omniauth['info'], :credentials => omniauth['credentials'])
  end
  
  
  
  def facebook
    if self.authentications.first.provider == 'facebook'
      @facebook ||= Koala::Facebook::GraphAPI.new(self.authentications.first.credentials['token'])
    end
  end
  
  def name
    "#{self.first_name} #{self.last_name}"
  end
  
end