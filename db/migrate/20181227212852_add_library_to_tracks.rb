class AddLibraryToTracks < ActiveRecord::Migration[5.2]
  def change
    add_reference :tracks, :library, foreign_key: true, index: true
  end
end
