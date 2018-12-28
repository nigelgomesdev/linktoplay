class CreatePlaylists < ActiveRecord::Migration[5.2]
  def change
    create_table :playlists do |t|
      t.string :title
      t.string :status
      t.integer :views

      t.timestamps
    end
    add_index :playlists, :status
  end
end
