class TestImageUploader < ImageUploader
  process resize_to_fit: [ 300, 200]
end
