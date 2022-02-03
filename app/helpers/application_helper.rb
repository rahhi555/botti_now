# frozen_string_literal: true

module ApplicationHelper
  # @return [User]
  def current_user
    id = session[:user_id]
    @current_user ||= User.find_by(id:) if id
  end
end
