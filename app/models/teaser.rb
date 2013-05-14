class Teaser < ActiveRecord::Base
  attr_accessible :content, :pictures_attributes, :movies_attributes, :push_check

  # 이미지 모델 polymorphic
  has_many :pictures, as: :imageable

  # 비디오 모델 polymorphic
  has_many :movies, as: :videoable

  belongs_to :event

  accepts_nested_attributes_for :pictures
  accepts_nested_attributes_for :movies

  scope :most_recent, order("created_at desc")

  def gcm_send
    gcm = GCM.new(ENV['GCM_API_KEY'])
    options = {data: {content: content, movies: movie_urls, images: image_urls}, collapse_key: Time.now}
    response = gcm.send_notification(gcm_reg_ids, options)
    update_attributes(push_check: true)
  end

  def gcm_reg_ids
    Gcm.all.collect { |g| g.reg_id }
  end

  def movie_urls
    movies.collect{|m| m.video_url}
  end

  def image_urls
    pictures.collect{|p| p.image_url}
  end
end
