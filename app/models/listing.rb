class Listing
  
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::TaggableWithContext
  include Origin::Queryable
  include Gmaps4rails::ActsAsGmappable

  acts_as_gmappable :process_geocoding => false

  field :listing
  field :type
  field :status
  field :price, type: Integer


  field :square_feet, type: Integer
  field :year, type: Integer
  field :acres, type: Float
  field :short_sale
  field :beds, type: Float
  field :baths, type: Float
  field :sub_division
  field :description
  field :garage_type
  field :garage_capacity, type: Integer
  field :carport_capacity, type: Integer
  taggable :features, :separator => ','
  taggable :pool, :separator => ','
  taggable :utilities, :separator => ','
  taggable :zoning, :separator => ','
  field :water
  taggable :landscape, :separator => ','
  field :brokered_by
  field :listing_timestamp, type: DateTime

  field :impressions, type: Integer
  index({ impressions: 1 }, { unique: true, background: true })

  index({ listing: 1 }, { unique: true})

  embeds_one :location, store_as: "location", as: :locatable, :cascade_callbacks => true
  embeds_many :images, :cascade_callbacks => true

  belongs_to :agent, inverse_of: :agent_listing
  belongs_to :office, inverse_of: :office_listing
  belongs_to :market


  attr_accessible :listing, :type, :status, :price, :square_feet, :year, :acres, :short_sale, :beds, :baths, :sub_division, :description, :garage_type, :garage_capacity, :carport_capacity, :features, :pool, :utilities, :water, :landscape, :zoning, :garage_type, :brokered_by, :listing_timestamp, :market_attributes, :location_attributes, :images_attributes, :agent_attributes, :office_attributes, :impressions

  accepts_nested_attributes_for :location, :market, :images, :agent, :office

  def gmaps4rails_address
    #describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
    "#{self.location.address_full}" 
  end

  # attr_accessible :location
  # accepts_nested_attributes_for :location

  def latitude
    location.latitude if location.latitude
  end

  def longitude
    location.longitude if location.longitude
  end

  def hit
    self.inc(:impressions, 1)
  end

  def default_image
    if self.images.count == 0
      "http://demo.lvh.me:3000/assets/default_listing.jpeg"
    else
      self.images.first.image.small.url
    end
    
  end

end