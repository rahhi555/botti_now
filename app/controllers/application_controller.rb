# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ApplicationHelper
  before_action :have_current_user

  def have_current_user
    unless current_user
      flash[:danger] = 'なんかエラーおきました(^_^;)ｻｰｾﾝ'
      redirect_to root_url
    end
  end
end
