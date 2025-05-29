class Item < ApplicationRecord
  belongs_to :user
  has_many :offers, dependent: :destroy
  has_one_attached :photo

  PLATFORMS = %w[PC XBOX PlayStation Nintendo Sega]
  GENRES = %w[Action Adventure Horror Platformer Shooter Slasher Sports Strategy Racing RPG]

  validates :platform, inclusion: { in: PLATFORMS }
  validates :genre, inclusion: { in: GENRES }

  validates :title, :genre, :platform, presence: true
  validates :title, uniqueness: { scope: :user, message: "you already added this game" }

  include PgSearch::Model
  pg_search_scope :search_by_params,
  against: [ :title, :platform, :genre, :description ],
  using: {
    tsearch: { prefix: true }
  }
end
