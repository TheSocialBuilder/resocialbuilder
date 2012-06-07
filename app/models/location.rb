class Location
  
  
  ## includes ##
  include Mongoid::Document
  include Mongoid::Timestamps
  include Geocoder::Model::Mongoid
  
  
  ## fields ##
  field :coordinates, :type => Array
  field :address, type: String
  field :address_formatted, type: String
  field :address_1, type: String
  field :address_2, type: String
  field :latitude, type: Float
  field :longitude, type: Float
  field :city, type: String
  field :county, type: String
  field :county_code, type: String
  field :state, type: String
  field :state_code, type: String
  field :zip, type: String
  field :country, type: String
  field :country_code, type: String
  
  
  

  ## associations ##
  belongs_to :locatable, polymorphic: true
  
  ## validations ##
  
  
  ## scopes ##
  
  
  ## callbacks ##
  geocoded_by :address_info
  after_validation :geocode
  
  ## methods ##
  
  geocoded_by :address_info do |obj,results|
    if geo = results.first
      
      
      #raise geo.to_yaml
      #$redis.set :address, geo.to_json
      obj.latitude     = geo.latitude
      obj.longitude    = geo.longitude
      obj.coordinates  = geo.coordinates
      obj.city         = geo.city
      
      
      address_info_1 = geo.address_components_of_type(:street_number).first
      address_info_2 = geo.address_components_of_type(:route).first
      
      obj.address_1 = address_info_1['long_name'] if address_info_2['long_name']
      obj.address_1 += " #{address_info_2['long_name']}" if address_info_2['long_name']
      obj.address = "#{obj.address_1}"
      obj.address += " #{obj.address_2}" if obj.address_2
      
      if county = geo.address_components_of_type(:administrative_area_level_2).first
        obj.county = county['long_name']
      end
      
      
      if county = geo.address_components_of_type(:administrative_area_level_2).first
        obj.county_code = county['short_name']
      end
      
      obj.state        = geo.state
      obj.state_code   = geo.state_code
      obj.zip          = geo.postal_code
      obj.country      = geo.country
      obj.country_code = geo.country_code
      obj.address_formatted = geo.address
      # raise obj.to_yaml
    end  
  end

  def address_info
    [address_1, address_2, city, state, zip, country].compact.join(' ')
  end
  
  
  
end