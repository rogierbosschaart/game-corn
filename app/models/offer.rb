class Offer < ApplicationRecord
  belongs_to :item
  belongs_to :user

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :start_date, comparison: { greater_than_or_equal_to: Date.current, message: "cannot be in the past" }, on: :create
  validates :end_date, comparison: { greater_than_or_equal_to: :start_date, message: "must be after the start date" }

end
