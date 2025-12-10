class ApplicationController < ActionController::Base
  # 1. Thêm dòng này để gọi hàm chọn layout
  layout :layout_by_resource

  private

  # 2. Định nghĩa hàm chọn layout
  def layout_by_resource
    if devise_controller?
      "auth"
    else
      "admin"
    end
  end
end