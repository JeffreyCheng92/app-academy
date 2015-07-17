# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  album_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  style      :string           not null
#  lyrics     :text             not null
#

class Track < ActiveRecord::Base
  validates :album_id, :name, :style, presence: true
  validates :style, inclusion: ["REGULAR", "BONUS"]

  has_many :notes

  belongs_to :album
  has_one :band, through: :album, source: :band
end
