# frozen_string_literal: true
require 'csv'

class ChaplusApiJob < ApplicationJob
  include ApplicationHelper

  queue_as :default
  sidekiq_options retry: false

  # @param [User] user ユーザー
  # @param [Post] post 送信する投稿
  # 会話BOTにpost.messageを送信し、BOTからの返信をpost.bot_messageとしてアップデートする。
  # その後、ツイートとBOT返信がブロードキャストされる。
  def perform(user, post)
    res = send_chaplus_api(user.name, post.message)
    # 返ってきたメッセージ。utterance = 発音という意味らしい
    bot_message = JSON.parse(res.body)['responses'].sample['utterance']
    post.update!(bot_message:)
    post.broadcast_append_to 'tweet_page', locals: { post:, user: }
    bot_broadcast(user, bot_message)
  rescue StandardError => e
    logger.error e

    post.destroy
    bot_broadcast(user, 'ごめんよく聞こえなかったずら...。もう一度言ってもらってもいいずら？')
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

  def bot_broadcast(user, bot_message)
    Turbo::StreamsChannel.broadcast_replace_to user,
                                               target: 'bot_message',
                                               partial: 'chaplus_api/message',
                                               locals: { bot_message: }
  end
end
