class MediaUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  # Thumbnail
  version :thumb do
    process :resize_to_limit => [150, 150]
  end
  
  # Small
  version :small do
    process :resize_to_limit => [25, 25]
  end
  
  # Medium
  version :medium do
    process :resize_to_limit => [50, 50]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def filename
     "#{timestamp}_#{id}.#{file.extension}" if original_filename.present?
  end
  
  def id
    model.id.to_s
  end

  def timestamp
    var = :"@#{mounted_as}_timestamp"
    model.instance_variable_get(var) or model.instance_variable_set(var, Time.now.to_i)
  end

end
