class AddStudioColumnForAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :style, :string
    change_column :albums, :style, :string, null: false
  end
end
