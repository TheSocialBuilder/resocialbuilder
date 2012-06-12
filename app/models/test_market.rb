class TestMarket
  include Mongoid::Document
  field :name, type: String
  field :something, type: String
  field :tester, type: String
end
