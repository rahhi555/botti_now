# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :uid, null: false

      t.timestamps
    end
    add_index :users, :uid, unique: true
  end
end
