class Movie < ActiveRecord::Base
  attr_accessible :videoable_id, :videoable_type, :video_url
  belongs_to :videoable, polymorphic: true

  validates :video_url, presence: true
end
