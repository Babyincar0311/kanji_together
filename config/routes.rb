Rails.application.routes.draw do
  get "home/index"
  # --- 1. CẤU HÌNH CHO USER (HỌC VIÊN) ---

  # Báo cho Devise dùng controller custom để xử lý đăng ký (gửi OTP)
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  # Route xác thực OTP (Dùng session nên không cần ID trên URL)
  get 'verify_otp', to: 'verification#new', as: :verify_otp
  post 'verify_otp', to: 'verification#create'

  # --- 2. CẤU HÌNH CHO ADMIN ---

  devise_for :admin_users, controllers: {
    registrations: 'admin/registrations',
    sessions: 'admin_users/sessions'
  }

  namespace :admin do
    # Trang chủ Dashboard Admin
    root to: "dashboard#index"

    # Route OTP riêng của Admin (Giữ nguyên code cũ của bạn)
    get  'verify_otp/:id', to: 'otp#new', as: 'verify_otp'
    post 'verify_otp/:id', to: 'otp#verify'

    # Route Quên mật khẩu Admin (Custom Flow)
    get   'recovery/new',      to: 'recovery#new',    as: 'forgot_password'
    post  'recovery',          to: 'recovery#create'
    get   'recovery/verify',   to: 'recovery#edit',   as: 'reset_password'
    patch 'recovery',          to: 'recovery#update'

    # Các Resources quản lý
    resources :kanjis
    resources :stories do
      member do
        put :approve
        put :reject
      end
    end
    resources :questions
    resources :users, only: [:index, :show, :edit, :update, :destroy]
  end

  # --- 3. TRANG CHỦ & HỆ THỐNG ---

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # QUAN TRỌNG: Trang chủ công khai (Landing Page)
  # User đăng nhập xong sẽ được Devise đưa về đây.
  # Bạn cần tạo HomeController: `rails g controller Home index`
  root to: "home#index"
end