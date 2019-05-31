class AddIndexInTracks < ActiveRecord::Migration[5.2]
  def change
    add_index :tracks, [:album_id, :title], unique: true
    add_index :tracks, :ord, unique: true
  end
end
