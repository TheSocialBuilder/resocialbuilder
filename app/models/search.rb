class Search
  
  
  ## includes ##
  include Mongoid::Document
  include Mongoid::Timestamps
  
  ## fields ##
  field :listing, type: String
  field :type, type: String
  field :city, type: String
  field :beds, type: Float
  field :baths, type: Float
  field :price_min, type: Integer
  field :price_max, type: Integer


  
  ## associations ##
  # belongs_to :account

  ## validations ##

  
  ## scopes ##
  
  
  ## callbacks ##
  
  
  ## methods ##
  
  
end