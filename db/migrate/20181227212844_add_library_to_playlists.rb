class AddLibraryToPlaylists < ActiveRecord::Migration[5.2]
  def change
    add_reference :playlists, :library, foreign_key: true, index: true
  end
end
