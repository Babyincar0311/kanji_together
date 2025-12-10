# app/controllers/admin_users/sessions_controller.rb
class AdminUsers::SessionsController < Devise::SessionsController
  # Gọi layout riêng cho trang login (file admin_login.html.erb)
  layout 'admin_login'

  # (Tùy chọn) Sau khi login xong thì nhảy vào Dashboard
  def after_sign_in_path_for(resource)
    admin_root_path # Tương ứng với dashboard#index
  end

  # (Tùy chọn) Sau khi logout thì quay lại trang login
  def after_sign_out_path_for(resource_or_scope)
    new_admin_user_session_path
  end
end