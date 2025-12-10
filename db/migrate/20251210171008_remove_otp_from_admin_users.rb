class RemoveOtpFromAdminUsers < ActiveRecord::Migration[8.1]
  def change
    remove_column :admin_users, :otp_code, :string
    remove_column :admin_users, :otp_sent_at, :datetime
    remove_column :admin_users, :is_verified, :boolean
  end
end
