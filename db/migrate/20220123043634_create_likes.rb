class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :user, type: :uuid, foreign_key: { on_delete: :nullify }
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
