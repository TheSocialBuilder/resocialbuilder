class Media
  
  
  ## includes ##
  include Mongoid::Document
  include Mongoid::Timestamps
  # include Mongoid::Versioning
  
  
  mount_uploader :media, MediaUploader
  
  embedded_in :uploadable, polymorphic: true
  
end