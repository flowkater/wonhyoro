class Attendship < ActiveRecord::Base
  attr_accessible :is_attend

  belongs_to :event
end
