class AddTopicColumnToShortenedUrl < ActiveRecord::Migration
  def change
    add_column :shortened_urls, :tag, :string
  end
end
