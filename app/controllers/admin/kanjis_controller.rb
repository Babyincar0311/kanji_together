class Admin::KanjisController < ApplicationController
  layout "admin" # Sử dụng giao diện Admin

  before_action :set_kanji, only: [:edit, :update, :destroy]

  def index
    # Lấy danh sách Kanji, mới nhất lên đầu, phân trang (nếu có gem kaminari) hoặc lấy hết
    @kanjis = Kanji.order(created_at: :desc)
  end

  def new
    @kanji = Kanji.new
  end

  def create
    @kanji = Kanji.new(kanji_params)
    if @kanji.save
      redirect_to admin_kanjis_path, notice: "Đã thêm Kanji thành công!"
    else
      flash.now[:alert] = "Lỗi! Vui lòng kiểm tra lại."
      render :new
    end
  end

  def edit
    # @kanji đã được tìm thấy nhờ before_action
  end

  def update
    if @kanji.update(kanji_params)
      redirect_to admin_kanjis_path, notice: "Cập nhật thành công!"
    else
      flash.now[:alert] = "Cập nhật thất bại."
      render :edit
    end
  end

  def destroy
    @kanji.destroy
    redirect_to admin_kanjis_path, notice: "Đã xóa Kanji."
  end

  private

  def set_kanji
    @kanji = Kanji.find(params[:id])
  end

  def kanji_params
    params.require(:kanji).permit(:character, :hanviet, :meaning, :onyomi, :kunyomi, :level, :strokes)
  end
end