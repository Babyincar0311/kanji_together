class AddOtpToUsers < ActiveRecord::Migration[7.0] # hoặc version của bạn
  def change
    add_column :users, :otp_code, :string
    add_column :users, :otp_sent_at, :datetime
    add_column :users, :is_verified, :boolean, default: false
  end
end