class User


  ## includes ##
  include Mongoid::Document
  include Mongoid::Timestamps



  ## fields ##
  field :first_name, type: String
  field :last_name, type: String
  field :name, type: String
  field :email, type: String
  field :phone, type: String

  # Facebook Omniauth Fields
  field :fb_id, type: String
  field :fb_info, type: Hash
  field :fb_token, type: String
  field :fb_token_expiration, type: DateTime
  field :fb_image, type: String

  attr_accessible :first_name, :last_name, :name, :email, :phone
  attr_accessible :fb_id, :fb_info, :fb_token, :fb_token_expiration, :fb_image

  ## callbacks ##

  ## methods ##

  def self.from_omniauth(omniauth)
    where(fb_id: omniauth.uid).find_or_initialize_by do |user|
      
      user.first_name = omniauth.info.first_name
      user.last_name = omniauth.info.last_name
      user.email = omniauth.info.email
    
      user.fb_id = omniauth.uid
      user.fb_info = omniauth.info
      user.fb_token = omniauth.credentials.token
      user.fb_token_expiration = Time.at(omniauth.credentials.expires_at)
      user.fb_image = omniauth.info.image
      
      user.save!
    end
  end

  def facebook
    @facebook ||= Koala::Facebook::GraphAPI.new(self.fb_token) if self.fb_token
  end
  
  # Format the users full name
  def name
    "#{self.first_name} #{self.last_name}"
  end

end