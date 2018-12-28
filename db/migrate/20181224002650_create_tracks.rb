class CreateTracks < ActiveRecord::Migration[5.2]
  def change
    create_table :tracks do |t|
      t.string :title
      t.string :status
      t.string :genre
      t.references :artist, foreign_key: true
      t.references :source, foreign_key: true
      t.string :source_link
      t.integer :views

      t.timestamps
    end
    add_index :tracks, :status
    add_index :tracks, :genre
  end
end
