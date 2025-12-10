class Admin::RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)

    if resource.save
      # 1. Sinh mã OTP và lưu vào DB
      resource.generate_otp!

      # 2. Gửi mail
      OtpMailer.send_otp(resource).deliver_now

      # 3. Không đăng nhập ngay, mà chuyển hướng sang trang nhập OTP
      redirect_to verify_otp_admin_path(id: resource.id), notice: "Đăng ký thành công! Vui lòng kiểm tra Email để lấy mã OTP."
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end
end