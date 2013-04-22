class Event < ActiveRecord::Base
	default_scope order 'created_at DESC'

	attr_accessible :title, :content, :is_vote
	mount_uploader :image, ImageUploader

	# 참석여부
	has_many :attendship, dependent: :destroy

	# 이미지 모델 polymorphic
  has_many :pictures, as: :imageable

  # 티저 모델
  has_many :teaser

	validates :image, presence: true 
	validates :title, presence: true 
	validates :content, presence: true 

	# formatting 된 created_at
	def created_day
		created_at.strftime("%Y. %m. %d.")
	end


	# def gcm_send(message)
 #    api_key = "AIzaSyDBXuqBYA5vju-s1WNAjate4llPszHP-zU"
 #    gcm = GCM.new(api_key)
 #    registration_ids = []
 #    registration_ids << gcm_regid
 #    options = {data: {text: message}, collapse_key: Time.now}
 #    # options = {data: {score: "123"}, collapse_key: "updated_score"}
 #    response = gcm.send_notification(registration_ids, options)
 #  end
end
