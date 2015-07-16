class User < ActiveRecord::Base
  validates :email, uniqueness: true, presence: true

  has_many :submitted_urls,
    class_name: :ShortenedUrl,
    primary_key: :id,
    foreign_key: :user_id

  has_many :visited_urls,
    class_name: :Visit,
    primary_key: :id,
    foreign_key: :short_url_id  
end
