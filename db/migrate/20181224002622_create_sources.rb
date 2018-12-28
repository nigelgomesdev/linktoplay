class CreateSources < ActiveRecord::Migration[5.2]
  def change
    create_table :sources do |t|
      t.string :title
      t.string :status
      t.string :domain

      t.timestamps
    end
    add_index :sources, :status
  end
end
