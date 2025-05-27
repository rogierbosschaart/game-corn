class Item < ApplicationRecord
  belongs_to :user
  has_many :offers
  has_one_attached :photo

  validates :title, :genre, :platform, presence: true
  validates :title, uniqueness: { scope: :user, message: "you already add this game" }
end
