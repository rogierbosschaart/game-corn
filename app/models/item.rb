class Item < ApplicationRecord
  belongs_to :user
  has_many :offers, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_one_attached :photo

  PLATFORMS = %w[PC XBOX PlayStation Nintendo Sega]
  GENRES = %w[Action Adventure Fighting Horror Platformer Shooter Slasher Sports Strategy Racing RPG]

  attribute :average_rating, :float, default: 0.0

  validates :platform, inclusion: { in: PLATFORMS }
  validates :genre, inclusion: { in: GENRES }

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  validates :title, :genre, :platform, presence: true
  validates :title, uniqueness: { scope: :user, message: "you already added this game" }

  def average_rating
    return 0 if ratings.empty?
    ratings.average(:value).to_f.round(1)
  end

  def update_average_rating
    update(average_rating: average_rating)
  end

  include PgSearch::Model
  pg_search_scope :search_by_params,
  against: [ :title, :platform, :genre, :description, :address ],
  using: {
    tsearch: { prefix: true }
  }
end
