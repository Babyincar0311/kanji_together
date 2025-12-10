
AdminUser.find_or_create_by!(email: 'phamgiakhang@gmail.com') do |admin|
  admin.password = 'Khang@311'
  admin.password_confirmation = 'Khang@311'
  admin.skip_confirmation!
  puts "Tạo thành công Admin User mặc định!"
end