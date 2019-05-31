class Album < ApplicationRecord
  validates :title, presence: true, uniqueness: { scope: :band_id }
  validates :live, inclusion: { in: [true, false] }
  validates :year, presence: true, numericality: { minimum: 1900, maximum: 2500 }
  after_initialize :live_default

  belongs_to :band,
    primary_key: :id,
    foreign_key: :band_id,
    class_name: :Band

  has_many :tracks,
    primary_key: :id,
    foreign_key: :album_id,
    class_name: :Track

  def live_default
    self.live ||= false
  end
end
