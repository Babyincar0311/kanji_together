class Admin::OtpController < ApplicationController
  # Sử dụng layout riêng cho phần đăng nhập (không có sidebar)
  layout "auth"

  def new
    @admin_user = AdminUser.find(params[:id])
  end

  def verify
    @admin_user = AdminUser.find(params[:id])

    # Kiểm tra mã người dùng nhập (params[:otp_code])
    if @admin_user.valid_otp?(params[:otp_code])

      # Nếu đúng: Cập nhật đã xác thực + Xóa mã OTP cũ
      @admin_user.update(is_verified: true, otp_code: nil)

      # Đăng nhập user vào hệ thống
      sign_in(@admin_user)

      redirect_to admin_root_path, notice: "Chào mừng bạn đến với trang quản trị!"
    else
      flash.now[:alert] = "Mã OTP không đúng hoặc đã hết hạn!"
      render :new
    end
  end
end