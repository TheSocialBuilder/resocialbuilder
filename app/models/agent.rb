class Agent
  
  
  ## includes ##
  include Mongoid::Document
  include Mongoid::Timestamps

  
  
  ## fields ##
  
  field :internal_agent_nrds_id, type: String
  field :internal_agent_id, type: String
  field :internal_office_id, type: String
  field :first_name, type: String
  field :last_name, type: String
  field :name, type: String
  field :phone, type: String
  field :email, type: String
  field :internal_agent_short_id, type: String
  field :internal_office_short_id, type: String
  field :active, type: Boolean, default: 0
  field :last_updated, type: DateTime
  
  # index({ internal_agent_id: 1 }, { unique: true})
  
  
  
  ## associations ##
  #belongs_to :account
  # has_many :listings
  belongs_to :mls_market
  
  ## validations ##
  
  
  ## scopes ##
  
  
  ## callbacks ##
  before_save :setup_name
  before_save :setup_phone
  
  ## methods ##
  
  def setup_name
    self.name = "#{self.first_name} #{self.last_name}"
  end
  
  def setup_phone
    if Phoner::Phone.valid? self.phone
      pn = Phoner::Phone.parse(self.phone)
      self.phone = pn.format("(%a)%f-%l")
    end
  end
end