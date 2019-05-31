class RemoveIndexInTracks < ActiveRecord::Migration[5.2]
  def change
    remove_index :tracks, [:album_id, :title]
    remove_index :tracks, :ord
  end
end
