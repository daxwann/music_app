class Note < ApplicationRecord
  validates :content, presence: true

  belongs_to :user,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  belongs_to :track,
    primary_key: :id,
    foreign_key: :track_id,
    class_name: :Track
end
