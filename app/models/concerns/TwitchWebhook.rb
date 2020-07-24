module TwitchWebhook
  extend ActiveSupport::Concern
  
  #included do
  #  before_create :set_webhook
  #end
  
  def set_webhook
    begin
      streamer_id = get_id
      headers = {"Content-Type": "application/json", "Client-ID": Rails.application.credentials.twitch[:client_id], "Authorization"=>"OAuth #{self.token}" }
      ["https://api.twitch.tv/helix/users/follows?first=1&to_id=#{streamer_id}", "https://api.twitch.tv/helix/subscriptions/events?broadcaster_id=#{streamer_id}&first=1"].each do |topic|
        payload = {"hub.mode": "subscribe",
          "hub.topic": topic,
          "hub.callback": "https://sevdemo.herokuapp.com/webhooks/event",
          "hub.lease_seconds": 864000 
        }
        RestClient::Request.execute(method: :post, url: "https://api.twitch.tv/helix/webhooks/hub", payload: payload, headers: headers)
      end
    rescue => e
      puts e.message
      puts e.backtrace
    end
  end
  
  def get_id
    resp = RestClient::Request.execute(method: :get, url: "https://api.twitch.tv/helix/users?login=#{self.fav_streamer_name}", headers:{
      "Accept"=> "application/vnd.twitchtv.v5+json",
      "Client-ID" => Rails.application.credentials.twitch[:client_id],
      "Authorization"=>"OAuth #{self.token}"})
    JSON.parse(resp)["users"].first["_id"]
  end
  
end