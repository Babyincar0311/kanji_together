class Admin::BaseController < ApplicationController
  layout "admin"
  before_action :require_admin_login!

  private

  def require_admin_login!
    unless session[:admin]
      redirect_to admin_login_path, alert: "Bạn cần đăng nhập admin"
    end
  end
end
