class Gcm < ActiveRecord::Base
  attr_accessible :reg_id

  validates :reg_id, presence: true 
end
