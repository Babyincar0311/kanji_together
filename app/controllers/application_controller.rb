class ApplicationController < ActionController::Base
  # 1. Gọi hàm chọn layout
  layout :layout_by_resource

  private # Chỉ cần viết private một lần là đủ

  # 2. Định nghĩa logic chọn layout thông minh hơn
  def layout_by_resource
    if devise_controller?
      "auth" # Layout riêng cho trang Đăng nhập/Đăng ký (nhớ phải có file layouts/auth.html.erb nhé)
    elsif params[:controller].start_with?("admin/")
      "admin" # Chỉ dùng AdminLTE cho các controller nằm trong thư mục Admin
    else
      "application" # Trang chủ (Home) và các trang User dùng layout bình thường
    end
  end

  # 3. Điều hướng sau khi đăng xuất
  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin_user
      new_admin_user_session_path
    elsif resource_or_scope == :user
      root_path
    else
      root_path
    end
  end
end