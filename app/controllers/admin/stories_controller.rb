class Admin::StoriesController < ApplicationController
  layout "admin" # <--- QUAN TRỌNG: Để áp dụng giao diện AdminLTE

  # Thêm :approve và :reject vào danh sách cần tìm ID trước
  before_action :set_story, only: [:show, :edit, :update, :destroy, :approve, :reject]

  def index
    # Logic: Lấy bài "pending" (Chờ duyệt - 0) lên đầu tiên để Admin dễ thấy
    # Dùng .includes(:kanji) để tránh lỗi N+1 query khi hiện tên Kanji
    @stories = Story.includes(:kanji).order(status: :asc, created_at: :desc)
  end

  def show
  end

  def new
    @story = Story.new
  end

  def create
    @story = Story.new(story_params)
    # Mặc định bài Admin tạo bằng tay thì cho duyệt luôn (approved)
    @story.status = :approved if @story.status.nil?

    if @story.save
      redirect_to admin_stories_path, notice: "Đã tạo Story thành công"
    else
      flash.now[:alert] = "Không thể tạo Story"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @story.update(story_params)
      redirect_to admin_stories_path, notice: "Đã cập nhật Story"
    else
      flash.now[:alert] = "Không thể cập nhật Story"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @story.destroy
    redirect_to admin_stories_path, notice: "Đã xóa Story"
  end

  # --- CÁC HÀNH ĐỘNG DUYỆT (Workflow) ---

  # PUT /admin/stories/1/approve
  def approve
    if @story.approved!
      redirect_back(fallback_location: admin_stories_path, notice: "Đã duyệt Story ##{@story.id}")
    else
      redirect_back(fallback_location: admin_stories_path, alert: "Lỗi không thể duyệt")
    end
  end

  # PUT /admin/stories/1/reject
  def reject
    # Logic: Từ chối thì chuyển status sang rejected (để lưu vết) hoặc xóa luôn
    if @story.rejected!
      redirect_back(fallback_location: admin_stories_path, notice: "Đã từ chối Story ##{@story.id}")
    else
      redirect_back(fallback_location: admin_stories_path, alert: "Lỗi xử lý")
    end
  end

  private

  def set_story
    @story = Story.find(params[:id])
  end

  def story_params
    params.require(:story).permit(:kanji_id, :content, :status)
  end
end