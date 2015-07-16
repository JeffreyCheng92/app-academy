class AddLyricsToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :lyrics, :text, null: false
  end
end
