class AddStyleToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :style, :string
    change_column :tracks, :style, :string, null: false
  end
end
