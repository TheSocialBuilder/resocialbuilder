class Listing
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::TaggableWithContext

  field :mls
  field :listing
  field :type
  field :status
  field :price, type: Integer
  field :address
  field :unit_number
  field :city
  field :state
  field :county
  field :zip
  field :mls_area
  field :square_feet, type: Integer
  field :year, type: Integer
  field :acres, type: Float
  field :short_sale
  field :beds, type: Integer
  field :baths, type: Integer
  field :sub_division
  field :description
  field :garage_type
  field :garage_capacity, type: Integer
  field :carport_capacity, type: Integer
  field :parking_capacity
  taggable :features, :separator => ','
  field :pool
  taggable :utilities, :separator => ','
  field :water
  taggable :landscape, :separator => ','
  field :zoning
  field :brokered_by
  field :office_id
  field :agent_id
  
  index({ listing: 1 }, { unique: true})
  
  embeds_one :location, as: :locatable
  embeds_many :images, :cascade_callbacks => true
  
  
  
  # attr_accessible :images_attributes, :mls, :mls_list_id, :list_type, :list_status, :list_price, :address, :unit_number, :city, :state, :county, :zip, :mls_area, :total_sq_ft, :year_built, :lot_acres, :short_sale, :total_bed, :total_bath, :sub_division, :public_remarks, :garage_type, :garage_capacity, :carport_capacity, :parking_capacity, :features, :pool, :utilities, :water, :landscape, :zoning, :brokered_by, :office_id, :agent_id
  
  # attr_accessible :location
  # accepts_nested_attributes_for :location
  
end
