class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  # Thumbnail
  version :thumb do
    process :resize_to_limit => [150, 150]
  end
  version :large do
    process :resize_and_pad => [500, 500]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def filename
     "#{timestamp}.#{file.extension}" if original_filename.present?
  end
  
  def timestamp
    var = :"@#{mounted_as}_timestamp"
    model.instance_variable_get(var) or model.instance_variable_set(var, Time.now.to_i)
  end
  

end
