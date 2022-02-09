# frozen_string_literal: true

module ApplicationHelper
  # @return [User]
  def current_user
    id = session[:user_id]
    @current_user ||= User.find_by(id:) if id
  end

  # @return [Integer]
  # 現在のコネクション数から自分を除いた数を返す
  # コネクション接続のタイミング上、初回の接続は自分を含めることができず-1になってしまう可能性があるため、
  # 計算結果がマイナスなら0を返す処理を入れている。
  def current_connection_length
    return_length = ActionCable.server.open_connections_statistics.length - 1
    return_length.negative? ? 0 : return_length
  end
end
