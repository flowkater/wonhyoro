class Noti < ActiveRecord::Base
  attr_accessible :content
  
  default_scope order 'created_at DESC'

  def gcm_send
    gcm = GCM.new(ENV['GCM_API_KEY'])
    options = {data: {content: content}, collapse_key: Time.now}
    response = gcm.send_notification(gcm_reg_ids, options)
  end
end
