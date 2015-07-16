class ChangeVisits < ActiveRecord::Migration
  def change
    change_column(:visits, :short_url, :integer, null: false)
    rename_column(:visits, :short_url, :short_url_id)
  end
end
