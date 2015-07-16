class Album < ActiveRecord::Base
  validates :band_id, :title, presence: true
end
