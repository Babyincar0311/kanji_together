class User < ApplicationRecord
  # Devise modules (Giữ nguyên các module bạn đang có)
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # --- 1. LOGIC CHẶN ĐĂNG NHẬP ---

  # Chỉ cho phép đăng nhập khi is_verified = true
  def active_for_authentication?
    super && is_verified?
  end

  # Thông báo lỗi nếu chưa verified
  def inactive_message
    is_verified? ? super : :not_verified
  end

  # --- 2. LOGIC OTP ---

  # Hàm sinh mã OTP ngẫu nhiên 6 số
  def generate_otp!
    self.otp_code = rand(100000..999999).to_s
    self.otp_sent_at = Time.now
    save!
  end

  # Hàm xác thực tài khoản
  def verify!
    update(is_verified: true, otp_code: nil)
  end
end