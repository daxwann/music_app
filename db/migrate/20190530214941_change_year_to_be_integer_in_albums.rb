class ChangeYearToBeIntegerInAlbums < ActiveRecord::Migration[5.2]
  def change
    remove_column :albums, :year
    add_column :albums, :year, :integer
  end
end
