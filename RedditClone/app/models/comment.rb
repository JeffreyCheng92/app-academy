# == Schema Information
#
# Table name: comments
#
#  id                :integer          not null, primary key
#  commentable_id    :integer          not null
#  commentable_type  :string           not null
#  parent_comment_id :integer
#  content           :text             not null
#  author_id         :integer          not null
#  post_id           :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Comment < ActiveRecord::Base
  TYPES = ["Comment", "Post"]

  validates :commentable, :content, :author, :post, presence: true
  validates :commentable_type, inclusion: TYPES

  belongs_to :commentable, polymorphic: true
  belongs_to :post
  belongs_to :author, class_name: "User", foreign_key: :author_id

  has_many :comments, as: :commentable

  belongs_to(
    :parent_comment,
    class_name: "Comment",
    foreign_key: :parent_comment_id
  )
end
