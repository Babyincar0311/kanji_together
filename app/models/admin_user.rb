class AdminUser < ApplicationRecord
  # Devise tự động thêm các module bảo mật
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # --- LOGIC OTP ---

  # 1. Chỉ cho phép đăng nhập nếu đã xác thực OTP (is_verified = true)
  def active_for_authentication?
    super && is_verified?
  end

  # Thông báo lỗi nếu chưa verify
  def inactive_message
    is_verified? ? super : :unverified
  end

  # 2. Hàm sinh mã OTP ngẫu nhiên 6 số
  def generate_otp!
    self.otp_code = rand(100000..999999).to_s
    self.otp_sent_at = Time.now
    save!
  end

  # 3. Hàm kiểm tra mã OTP người dùng nhập vào
  def valid_otp?(input_code)
    # Sai mã
    return false if otp_code != input_code

    # Mã hết hạn (quá 5 phút)
    return false if otp_sent_at < 5.minutes.ago

    true
  end
end