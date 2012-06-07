class Image
  
  
  ## includes ##
  include Mongoid::Document
  include Mongoid::Timestamps
  # include Mongoid::Versioning
  
  
  mount_uploader :image, ImageUploader
  
  belongs_to :listing
  
end