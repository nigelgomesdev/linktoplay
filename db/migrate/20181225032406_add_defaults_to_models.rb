class AddDefaultsToModels < ActiveRecord::Migration[5.2]
  def change
    change_column_default :playlists, :status, from: nil, to: 'active'
    change_column_default :playlists, :views, from: nil, to: 0
    change_column_default :tracks, :status, from: nil, to: 'active'
    change_column_default :tracks, :views, from: nil, to: 0
    change_column_default :sources, :status, from: nil, to: 'active'
  end
end