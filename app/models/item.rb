class Item < ApplicationRecord
  belongs_to :user
  has_many :offers, dependent: :destroy
  has_one_attached :photo

  PLATFORMS = %w[PC XBOX PlayStation Nintendo Sega]
  GENRES = %w[RPG Shooter Strategy Racing Slasher Horror Stealth Platformer Action Sport Fighting]

  validates :platform, inclusion: { in: PLATFORMS }
  validates :genre, inclusion: { in: GENRES }

  validates :title, :genre, :platform, presence: true
  validates :title, uniqueness: { scope: :user, message: "you already added this game" }
end
