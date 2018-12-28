class RemoveUserFromPlaylists < ActiveRecord::Migration[5.2]
  def change
    remove_reference :playlists, :user, foreign_key: true
  end
end
