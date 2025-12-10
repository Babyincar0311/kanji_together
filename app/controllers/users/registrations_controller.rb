class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super do |resource|
      if resource.persisted?
        # 1. Sinh OTP & Gửi mail
        resource.generate_otp!
        UserMailer.send_otp(resource).deliver_now

        # 2. Ngăn không cho đăng nhập ngay -> Chuyển sang trang nhập OTP
        if resource.active_for_authentication?
          set_flash_message! :notice, :signed_up
          sign_up(resource_name, resource)
        else
          # Lưu ID vào session để trang sau biết ai đang nhập mã
          session[:verification_user_id] = resource.id
          return redirect_to verify_otp_path
        end
      end
    end
  end
end