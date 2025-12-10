class Admin::RecoveryController < ApplicationController
  layout "auth" # Dùng layout login (không có menu)

  # 1. Hiển thị form nhập Email
  def new
  end

  # 2. Xử lý: Tìm user -> Gửi OTP
  def create
    @admin_user = AdminUser.find_by(email: params[:email])

    if @admin_user
      # Tái sử dụng hàm sinh OTP và Mailer đã làm ở phần Đăng ký
      @admin_user.generate_otp!
      OtpMailer.send_otp(@admin_user).deliver_now

      # Chuyển sang trang nhập OTP, kèm theo email trên URL để biết đang reset cho ai
      redirect_to admin_reset_password_path(email: @admin_user.email), notice: "Mã OTP xác thực đã được gửi vào email của bạn."
    else
      flash.now[:alert] = "Email không tồn tại trong hệ thống."
      render :new
    end
  end

  # 3. Hiển thị form nhập OTP + Pass mới
  def edit
    @email = params[:email]
  end

  # 4. Xử lý: Check OTP -> Đổi Pass
  def update
    @admin_user = AdminUser.find_by(email: params[:email])

    # Kiểm tra xem user có tồn tại và OTP có đúng không
    if @admin_user && @admin_user.valid_otp?(params[:otp_code])

      # Kiểm tra mật khẩu xác nhận khớp không
      if params[:password] != params[:password_confirmation]
        flash.now[:alert] = "Mật khẩu xác nhận không khớp."
        @email = params[:email]
        render :edit
        return
      end

      # Cập nhật mật khẩu mới (Devise sẽ tự mã hóa)
      if @admin_user.update(password: params[:password], password_confirmation: params[:password_confirmation])
        # Xóa OTP sau khi dùng xong & Verify tài khoản luôn (nếu chưa verify)
        @admin_user.update(otp_code: nil, is_verified: true)

        # Đăng nhập user vào luôn
        sign_in(@admin_user)

        redirect_to admin_root_path, notice: "Đổi mật khẩu thành công!"
      else
        flash.now[:alert] = @admin_user.errors.full_messages.join(", ")
        @email = params[:email]
        render :edit
      end

    else
      flash.now[:alert] = "Mã OTP sai hoặc đã hết hạn!"
      @email = params[:email]
      render :edit
    end
  end
end