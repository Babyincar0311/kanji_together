class Admin::BaseController < ApplicationController# Sử dụng layout AdminLTE
  before_action :authenticate_admin_user!
end