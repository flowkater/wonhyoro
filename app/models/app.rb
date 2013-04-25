class App < ActiveRecord::Base
  attr_accessible :version, :store_url

  validates :version, presence: true
  validates :store_url, presence: true
end
