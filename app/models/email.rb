class Email
  
  
  ## includes ##
  include Mongoid::Document
  include Mongoid::Timestamps
  
  ## fields ##
  field :email, type: String  
  
  ## associations ##
  embedded_in :account
  
  attr_accessible :email
  
  ## validations ##
  validates_presence_of :email
  
  ## scopes ##
  
  
  ## callbacks ##
  
  
  ## methods ##
  
  
end