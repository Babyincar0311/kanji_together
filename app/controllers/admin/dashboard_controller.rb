class Admin::DashboardController < ApplicationController
  def index
    # Đổi tên biến cho khớp với file View đã tạo
    @user_count     = User.count
    @story_count    = Story.count
    @question_count = Question.count
    @kanji_count    = Kanji.count

    # Các dữ liệu bổ sung (nếu sau này muốn hiển thị list mới nhất)
    @latest_users   = User.order(created_at: :desc).limit(5)
    @latest_stories = Story.order(created_at: :desc).limit(5)
  end
end