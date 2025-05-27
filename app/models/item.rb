class Item < ApplicationRecord
  belongs_to :user
  has_many :offers

  validates :title, :genre, :platform, :poster_url, presence: true
  validates :title, uniqueness: { scope: :user, message: "you already add this game" }
end
