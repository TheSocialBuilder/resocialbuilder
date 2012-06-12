class Office
  
  
  ## includes ##
  include Mongoid::Document
  include Mongoid::Timestamps

  
  
  ## fields ##
  
  field :internal_office_id, type: String
  field :internal_office_nrds_id, type: String
  field :name, type: String
  field :phone, type: String
  field :email, type: String
  field :internal_office_short_id, type: String
  field :active, type: Boolean, default: 0
  field :last_updated, type: DateTime
  
  # index({ internal_agent_id: 1 }, { unique: true})
  
  
  
  ## associations ##

  belongs_to :mls_market
  # has_many :agents
  embeds_one :location, store_as: "location", as: :locatable, :cascade_callbacks => true
  
  
  attr_accessible :internal_office_id, :internal_office_nrds_id, :name, :phone, :email, :internal_office_short_id, :active, :last_updated, :mls_market_attributes, :location_attributes
  
  # attr_accessible :location
  accepts_nested_attributes_for :location, :mls_market
  
  
  
  ## validations ##
  
  
  ## scopes ##
  
  
  ## callbacks ##
  before_save :setup_phone
  
  ## methods ##
  
  def setup_phone
    if Phoner::Phone.valid? self.phone
      pn = Phoner::Phone.parse(self.phone)
      self.phone = pn.format("(%a)%f-%l")
    end
  end
end