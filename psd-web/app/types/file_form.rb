class FileForm < ActiveModel::Type::Value
  def cast(value)
    UploadedFile.new(value[:file])
  end
end
