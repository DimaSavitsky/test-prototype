class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  WHITELIST_EXTENSIONS =  %w(jpg jpeg png bmp)

  def full_filename(for_file)
    original_name = model.try('read_attribute', mounted_as) || for_file
    full_name = [Digest::MD5.hexdigest(original_name), File.extname(original_name)].join
    version_name ? [version_name, full_name].join('/') : full_name
  end

  def cache_name
    if cache_id && original_filename
      full_name = [Digest::MD5.hexdigest(full_original_filename), File.extname(full_original_filename)].join
      File.join(cache_id, full_name)
    end
  end

  def store_dir
    "images/#{model.class.to_s.underscore}/#{model.id}"
  end

  def cache_dir
    Rails.root.join 'tmp/uploads'
  end

  def extension_white_list
    WHITELIST_EXTENSIONS
  end

end
