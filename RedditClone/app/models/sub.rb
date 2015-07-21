# == Schema Information
#
# Table name: subs
#
#  id           :integer          not null, primary key
#  title        :string           not null
#  description  :text             not null
#  moderator_id :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Sub < ActiveRecord::Base
  validates :moderator, :title, :description, presence: true
  validates :title, uniqueness: true

  belongs_to(:moderator,
    class_name: "User",
    inverse_of: :subs)

  has_many(
    :post_subs,
    dependent: :destroy,
    inverse_of: :sub
  )

  has_many(
    :posts,
    through: :post_subs,
    dependent: :destroy
    )
end
