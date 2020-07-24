class SessionsController < Devise::OmniauthCallbacksController
  
  def new;end

  def twitch
    user = User.twitch_data(twitch_params)
    if user.present?
      sign_out_all_scopes
      flash[:success] = t 'devise.omniauth_callbacks.success', kind: 'Twitch'
      sign_in_and_redirect user, event: :authentication
    else
      flash[:alert] = t 'devise.omniauth_callbacks.failure', kind: 'Twitch', reason: "#{auth.info.email} is not authorized."
      redirect_to new_user_session_path
    end
  end

  def failure
    
  end
  
  private

  def twitch_params
    @twitch_params ||= {
      uid: auth.uid,
      email: auth.info.email,
      name: auth.info.name,
      nickname: auth.info.nickname,
      image_url: auth.info.image,
      token: auth.credentials.token,
      refresh_token: auth.credentials.refresh_token
    }
  end

  def auth
    @auth ||= request.env['omniauth.auth']
  end
  
end
