class AddIndexToOrdInTracks < ActiveRecord::Migration[5.2]
  def change
    add_index :tracks, [:album_id, :ord], unique: true
  end
end
