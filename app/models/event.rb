class Event < ApplicationRecord
  
  enum event_type: [:follow, :subscription]
  after_create :send_nofitication
  
  def send_nofitication
    User.where("LOWER(fav_streamer_name)=LOWER('#{self.streamer_name}')").all.each do |u|
      ActionCable.server.broadcast "web_notifications_channel:#{u.id}", content: {viewer_name: self.viewer_name, event_type: self.event_type, streamer_name: self.streamer_name} 
    end
  end
end
