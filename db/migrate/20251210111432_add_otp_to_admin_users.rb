class AddOtpToAdminUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :admin_users, :otp_code, :string
    add_column :admin_users, :otp_sent_at, :datetime
    add_column :admin_users, :is_verified, :boolean, default: false
  end
end
