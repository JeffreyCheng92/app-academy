# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text             not null
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  validates :title, :content, :subs, :author, presence: true

  belongs_to(
    :author,
    class_name: :User,
    inverse_of: :posts
  )

  has_many(
    :post_subs,
    dependent: :destroy,
    inverse_of: :post
  )

  has_many :total_comments

  has_many :comments, as: :commentable

  has_many :subs, through: :post_subs
end
