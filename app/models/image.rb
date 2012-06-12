class Image
  
  
  ## includes ##
  include Mongoid::Document
  include Mongoid::Timestamps
  # include Mongoid::Versioning
  
  field :description, type: String
  field :preferred, type: Boolean
  field :location, type: String
  field :image_content_id, type: String
  field :image_object_id, type: Integer
  
  mount_uploader :image, ImageUploader
  
  belongs_to :listing
  
end