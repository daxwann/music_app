class Album < ApplicationRecord
  validates :title, presence: true, uniqueness: { scope: :band_id }
  validates :live, presence: true, inclusion: { in: [true, false] }

  belongs_to :band,
    primary_key: :id,
    foreign_key: :band_id,
    class_name: :Band
end
