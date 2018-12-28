class CreateLibraries < ActiveRecord::Migration[5.2]
  def change
    create_table :libraries do |t|
      t.references :user, foreign_key: true, index: true
      t.timestamps
    end
  end
end
