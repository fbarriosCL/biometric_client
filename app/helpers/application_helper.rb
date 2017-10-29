module ApplicationHelper
  def image_base64 image
    "data:image/jpeg;base64, #{ image }"
  end
end
