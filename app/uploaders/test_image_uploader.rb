class TestImageUploader < ImageUploader
  process resize_to_fill: [ 215, 215]
end
