class Transaction
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :transaction_date, type: DateTime
  field :transaction_action, type: String
  field :approval_code, type: String
  field :response_code, type: String
  field :response_message, type: String
  field :transaction_id, type: String
  field :base_amount, type: String
  field :message, type: String
  field :success, type: Boolean
  field :authorization, type: String
  field :card_id, :type => BSON::ObjectId
  field :realtor_id, :type => BSON::ObjectId
  
  
  # belongs_to :chargable, polymorphic: true
  belongs_to :account
  has_one :card
  has_one :realtor
  
  
  attr_accessible :card_id, :realtor_id, :transaction_date, :transaction_action, :approval_code, :response_code, :response_message, :transaction_id, :transaction_id, :base_amount, :message, :success, :authorization, :title



  
end
