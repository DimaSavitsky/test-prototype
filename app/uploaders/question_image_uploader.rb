class QuestionImageUploader < ImageUploader

  process resize_to_fill: [584, 584]

  version :thumb do
    process resize_to_fit: [215, 215]
  end

end
