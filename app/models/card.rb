class Card
  include Mongoid::Document
  
  field :name
  field :number
  field :type
  field :month
  field :year
  field :verification_value
  
  # belongs_to :chargable, polymorphic: true
  belongs_to :account
  belongs_to :transaction
  
  validates_presence_of :name, :number, :type, :month, :year, :verification_value

  
end
