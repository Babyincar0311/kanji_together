Rails.application.routes.draw do
  # 1. Cấu hình Devise
  # Thêm 'sessions' để trỏ vào controller có layout 'admin_login'
  devise_for :admin_users, controllers: {
    registrations: 'admin/registrations',
    sessions: 'admin_users/sessions'
  }

  namespace :admin do
    # Trang chủ admin
    root to: "dashboard#index"

    # --- ROUTE OTP ĐĂNG KÝ ---
    get  'verify_otp/:id', to: 'otp#new', as: 'verify_otp'
    post 'verify_otp/:id', to: 'otp#verify'

    # --- ROUTE QUÊN MẬT KHẨU (Custom Flow) ---
    get   'recovery/new',      to: 'recovery#new',    as: 'forgot_password'
    post  'recovery',          to: 'recovery#create'
    get   'recovery/verify',   to: 'recovery#edit',   as: 'reset_password'
    patch 'recovery',          to: 'recovery#update'

    # --- CRUD Resources ---
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

  # Chuyển hướng mặc định về trang admin
  root to: redirect("/admin")

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
end