class Track < ApplicationRecord
  validates :title, presence: true
  validates :ord, presence: true, uniqueness: { scope: :album_id }
  validates :lyrics, presence: true
  validates :bonus, inclusion: { in: [true, false] }

  belongs_to :album,
    primary_key: :id,
    foreign_key: :album_id,
    class_name: :Album

  belongs_to :band,
    through: :album,
    source: :band
end
