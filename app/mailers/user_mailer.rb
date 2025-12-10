class UserMailer < ApplicationMailer
  default from: 'no-reply@kanjitogether.com' # Sửa thành email của bạn

  def send_otp(user)
    @user = user
    @otp = user.otp_code
    mail(to: @user.email, subject: 'Mã xác thực tài khoản Kanji Together')
  end
end