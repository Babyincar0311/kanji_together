Rails.application.routes.draw do
  namespace :admin do
    # Trang chủ admin (Truy cập bằng /admin)
    root to: "dashboard#index"

    # Auth
    get    "login",  to: "sessions#new"
    post   "login",  to: "sessions#create"
    delete "logout", to: "sessions#destroy"

    # CRUD
    resources :kanjis
    resources :stories do
      member do
        put :approve
        put :reject
      end
    end

    resources :questions do
      member do
        put :approve
        put :reject
      end
    end

    resources :users, only: [:index, :show, :edit, :update, :destroy]
  end


  root to: redirect("/admin")

  get "up" => "rails/health#show", as: :rails_health_check
end