class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :item

  validates :user_id, uniqueness: { scope: :item_id, message: "You already rated this game" }
  validates :value, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }

  after_destroy :update_item_average_rating

  private

  def update_item_average_rating
    item.update_average_rating
  end
end
