class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :title
      t.string :platform
      t.string :genre
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
