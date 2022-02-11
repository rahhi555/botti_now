# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ApplicationHelper
  include FlashHelper

  before_action :have_current_user

  def have_current_user
    unless current_user
      flash[:danger] = 'なんかエラーおきました(^_^;)ｻｰｾﾝ'
      redirect_to root_url
    end
  end

  def turbo_stream_flash
    turbo_stream.replace('flash_bar', partial: 'layouts/flash', locals: { **flash_attributes })
  end

  # @param [ActiveRecord]
  def turbo_stream_error_messages(object)
    turbo_stream.replace('error_messages', partial: 'shared/error_messages', object:)
  end
end
