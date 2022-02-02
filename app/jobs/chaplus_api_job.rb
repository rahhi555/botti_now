# frozen_string_literal: true

class ChaplusApiJob < ApplicationJob
  queue_as :default

  # @param [User] user ユーザー
  # @param [String] utterance 会話BOTに送信する会話テキスト
  def perform(user, utterance)
    res = send_chaplus_api(user.name, utterance)
    # 返ってきたメッセージ。utterance = 発音という意味らしい
    utterance = JSON.parse(res.body)['responses'][0]['utterance']
  end

  private

  def send_chaplus_api(username, utterance)
    chaplus_api_key = Rails.application.credentials.chaplus_api_key
    params = { utterance:,
               username:,
               agentState: { agentName: 'ぼっちわん', tone: 'koshu', age: '20歳' } }
    Net::HTTP.post URI("https://www.chaplus.jp/v1/chat?apikey=#{chaplus_api_key}"),
                   params.to_json, 'Content-Type' => 'application/json'
  end
end
