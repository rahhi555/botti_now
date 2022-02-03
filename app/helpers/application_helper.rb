# frozen_string_literal: true

module ApplicationHelper
  def current_user
    p '--------------'
    p try(:session)
    # id = session[:user_id]
    session = try(:session)
    id = session ? session[:user_id] : nil
    @current_user ||= User.find_by(id:) if id
  end
end
