class Event < ActiveRecord::Base
	default_scope order 'created_at DESC'

	attr_accessible :title, :content, :is_vote, :count, :fromdate, :todate

	# 참석여부
	has_many :attendship, dependent: :destroy

	# 이미지 모델 polymorphic
  has_many :pictures, as: :imageable

  # 티저 모델
  has_many :teasers

	validates :title, presence: true 
	validates :content, presence: true 
	validates :fromdate, presence: true
	validates :todate, presence: true

	def count_plus
		update_attributes(count: self.count + 1)
	end

	# formatting 된 created_at
	def created_day
		created_at.strftime("%Y. %m. %d.")
	end

	def event_duration
		"#{fromdate.strftime("%Y. %m. %d.")} ~ #{todate.strftime("%Y. %m. %d.")}"
	end

	def recent_image
		pictures.first.image.to_s
	end
end
