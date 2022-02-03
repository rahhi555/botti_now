class AddBotMessageToPost < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :bot_message, :string
  end
end
