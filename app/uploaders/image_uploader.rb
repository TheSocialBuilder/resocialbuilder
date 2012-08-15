class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  # Thumbnail
  version :thumb do
    process :resize_to_limit => [75, 75]
  end

  version :small do
    process :resize_to_limit => [200, 200]
  end

  version :large do
    process :resize_and_pad => [500, 500]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def filename
     "#{model.image_content_id}_#{model.image_object_id}.#{file.extension}" if original_filename.present?
  end
  

end
