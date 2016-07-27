class QuestionImageUploader < ImageUploader

  process resize_to_fit: [800, 600]

  version :thumb do
    process resize_to_fit: [200, 150]
  end

end
