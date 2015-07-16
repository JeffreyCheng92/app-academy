require 'action_view'

class Cat < ActiveRecord::Base
  include ActionView::Helpers::DateHelper

  CAT_COLORS = %w(black white orange brown)

  has_many(
    :rental_requests,
    -> { order :start_date },
    class_name: "CatRentalRequest",
    dependent: :destroy,
    inverse_of: :cat
  )

  has_many(
    :rental_requesters,
    through: :rental_requests,
    source: :requester
  )

  validates(
    :birth_date,
    :color,
    :name,
    :sex,
    presence: true
  )

  belongs_to(
    :user,
    class_name: 'User'
  )

  validates :color, inclusion: CAT_COLORS
  validates :sex, inclusion: %w(M F)

  def age
    time_ago_in_words(birth_date)
  end
end
