class Card
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia
  # include Mongoid::Versioning
  
  field :name
  field :number
  field :number_full
  field :type
  field :month
  field :year
  field :verification_value
  field :default, :type => Boolean, :default => 0
  
  # belongs_to :chargable, polymorphic: true
  belongs_to :account
  belongs_to :transaction
  
  validates_presence_of :name, :number, :type, :month, :year, :verification_value
  
  
  before_save :mask_number
  
  def mask_number
    self.number_full = self.number
    self.number = "XXXX-XXXX-XXXX-"+self.number[-4..-1]
  end
  

end
