class DashboardController < ApplicationController
  protect_from_forgery with: :exception, :except => [:webhooks, :get_webhooks]
  before_action :authenticate_user!, except: [:webhooks, :get_webhooks]
  
  def index
    @events = Event.where("LOWER(streamer_name)=LOWER('#{current_user.fav_streamer_name}')").order("created_at desc").limit(10) rescue []
  end
  
  def webhooks
    puts params
    begin
      params["data"].each do |data|
        if data["event_type"] == "subscriptions.subscribe"
          Event.create streamer_name: data["broadcaster_name"], event_type: 1, viewer_name: data["user_name"]
        else
          Event.create streamer_name: data["to_name"], event_type: 0, viewer_name: data["from_name"]  
        end
      end
    rescue => e
      puts e.message
    end
    head 200, content_type: "text/html"
  end
  
  def get_webhooks
    render plain: params["hub.challenge"]
  end
  
  def save_fav_streamer
    current_user.update_attributes fav_streamer_name: params[:name]
    current_user.set_webhook
  end
  
end
