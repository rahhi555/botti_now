# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.text :message, null: false
      t.references :user, type: :uuid, foreign_key: { on_delete: :nullify }

      t.timestamps
    end
  end
end
