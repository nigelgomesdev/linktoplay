class AddUserToPlaylists < ActiveRecord::Migration[5.2]
  def change
    add_reference :playlists, :user, foreign_key: true, index: true
  end
end
