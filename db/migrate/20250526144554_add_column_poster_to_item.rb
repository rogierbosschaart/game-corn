class AddColumnPosterToItem < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :poster_url, :string
  end
end
