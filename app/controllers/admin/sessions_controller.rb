class Admin::SessionsController < ApplicationController
  layout "admin_login"
  skip_before_action :verify_authenticity_token, only: [:create]  # tùy chọn nếu login API hoặc form không có CSRF token

  def new
  end

  def create
    admin_email    = Rails.application.credentials.admin[:email]
    admin_password = Rails.application.credentials.admin[:password]

    if params[:email] == admin_email && params[:password] == admin_password
      session[:admin_id] = "ok"
      redirect_to admin_dashboard_path, notice: "Đăng nhập thành công"
    else
      flash.now[:alert] = "Sai email hoặc mật khẩu"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:admin_id)
    redirect_to admin_login_path, notice: "Đã đăng xuất"
  end
end
