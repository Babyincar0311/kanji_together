class Admin::StoriesController < ApplicationController
  before_action :set_story, only: [:show, :edit, :update, :destroy]

  def index
    @stories = Story.order(id: :desc)
  end

  def show
  end

  def new
    @story = Story.new
  end

  def create
    @story = Story.new(story_params)
    if @story.save
      redirect_to admin_story_path(@story), notice: "Đã tạo Story thành công"
    else
      flash.now[:alert] = "Không thể tạo Story"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @story.update(story_params)
      redirect_to admin_story_path(@story), notice: "Đã cập nhật Story"
    else
      flash.now[:alert] = "Không thể cập nhật Story"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @story.destroy
    redirect_to admin_stories_path, notice: "Đã xóa Story"
  end

  private

  def set_story
    @story = Story.find(params[:id])
  end

  def story_params
    params.require(:story).permit(:title, :content, :level, :image_url)
  end
end
