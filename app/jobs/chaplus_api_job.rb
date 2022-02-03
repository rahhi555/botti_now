# frozen_string_literal: true
require 'csv'

class ChaplusApiJob < ApplicationJob
  queue_as :default
  sidekiq_options retry: false

  # @param [User] user ユーザー
  # @param [String] utterance 会話BOTに送信する会話テキスト
  def perform(user, utterance)
    res = send_chaplus_api(user.name, utterance)
    # 返ってきたメッセージ。utterance = 発音という意味らしい
    message = JSON.parse(res.body)['responses'].sample['utterance']
    bot_broadcast(user, message)
  rescue StandardError => e
    Rails.logger.error e
    message = 'ごめんよく聞こえなかったずら...。もう一度言ってもらってもいいずら？'
    bot_broadcast(user, message)
  end

  private

  def send_chaplus_api(username, utterance)
    chaplus_api_key = Rails.application.credentials.chaplus_api_key
    ngwords = CSV.read("#{Rails.root}/lib/ngwords.csv").flatten
    params = { utterance:,
               username:,
               agentState: { agentName: 'ぼっちわん', tone: 'koshu', age: '20歳' },
               addition: {
                 ngwords:
               }}
    Net::HTTP.post URI("https://www.chaplus.jp/v1/chat?apikey=#{chaplus_api_key}"),
                   params.to_json, 'Content-Type' => 'application/json'
  end

  def bot_broadcast(user, message)
    Turbo::StreamsChannel.broadcast_replace_to user,
                                               target: 'bot_message',
                                               partial: 'chaplus_api/message',
                                               locals: { message: }
  end
end
