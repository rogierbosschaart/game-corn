class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :username, null: false, unique: true
      t.string :password, null: false
      t.string :city
      t.timestamps
    end
  end
end
