class OtpMailer < ApplicationMailer
  default from: 'kanji.together.admin@gmail.com' # Bạn có thể thay bằng email của bạn

  def send_otp(admin_user)
    @admin_user = admin_user
    @otp = admin_user.otp_code

    # Gửi mail
    mail(to: @admin_user.email, subject: '[Kanji Together] Mã xác thực Admin')
  end
end
