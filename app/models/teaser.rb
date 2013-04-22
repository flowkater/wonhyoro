class Teaser < ActiveRecord::Base
  attr_accessible :content

  # 이미지 모델 polymorphic
  has_many :pictures, as: :imageable

  # 비디오 모델 polymorphic
  has_many :movies, as: :videoable

  belongs_to :event
end
