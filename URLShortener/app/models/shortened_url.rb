require "securerandom"

class ShortenedUrl < ActiveRecord::Base
  belongs_to :submitter,
    class_name: :User,
    primary_key: :id,
    foreign_key: :user_id

  has_many :visitors,
    class_name: :Visit,
    primary_key: :id,
    foreign_key: :user_id

  has_many :people,  #this is the book specified method
    Proc.new { distinct },
    through: :visits,
    source: :visitor

  def self.random_code
    code = SecureRandom.urlsafe_base64
    code = SecureRandom.urlsafe_base64 until !ShortenedUrl.exists?(short_url: code)
    code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    hash = { user_id: user.id, long_url: long_url, short_url: ShortenedUrl.random_code }
    ShortenedUrl.create!(hash)
  end

  def num_clicks
    visitors.count
  end

  def num_uniques # without 'through'
    visitors.select(:user_id).distinct.count
  end

  def num_uniques_test #book speicifed method
    :people
  end

  def num_recent_uniques
    visitors.where(:created_at => 10.minutes.ago .. 0.minutes.ago).count
  end

end
