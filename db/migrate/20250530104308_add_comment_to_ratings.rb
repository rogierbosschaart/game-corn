class AddCommentToRatings < ActiveRecord::Migration[7.1]
  def change
    add_column :ratings, :comment, :text
  end
end
