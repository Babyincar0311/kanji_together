# app/models/admin_user.rb
class AdminUser < ApplicationRecord
  # Admin không cho đăng ký (registerable) và không cần confirm email (confirmable)
  devise :database_authenticatable, :recoverable,
         :rememberable, :validatable

  # --- BẠN CÓ THỂ XÓA HẾT CÁC HÀM LIÊN QUAN ĐẾN OTP Ở ĐÂY ĐI ---
  # Admin đăng nhập chỉ cần Email + Pass là vào thẳng Dashboard
end