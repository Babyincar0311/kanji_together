class VerificationController < ApplicationController
  layout "auth"
  def new
    # Chỉ hiển thị form
  end

  def create
    user = User.find_by(id: session[:verification_user_id])

    if user && user.otp_code == params[:otp_code]
      # OTP đúng -> Kích hoạt & Đăng nhập
      user.verify!
      session.delete(:verification_user_id) # Xóa session tạm
      sign_in(user) # Đăng nhập luôn cho user
      redirect_to root_path, notice: "Chào mừng! Tài khoản đã được kích hoạt."
    else
      flash.now[:alert] = "Mã OTP không đúng hoặc đã hết hạn."
      render :new
    end
  end
end