class GoogleAuthController < ApplicationController
  API_SCOPE = [
      'https://www.googleapis.com/auth/youtube.force-ssl',
      'https://www.googleapis.com/auth/youtube',
      'https://www.googleapis.com/auth/youtubepartner',
      'https://www.googleapis.com/auth/youtube.upload',
    ]

  def start
    session[:return_url] = params[:return_url]

    redirect_to auth_service.get_authorization_uri(redirect_uri: callback_url, scope: API_SCOPE)
  end

  def callback
    tokens = auth_service.fetch_tokens(redirect_uri: callback_url, scope: API_SCOPE, code: params[:code])

    if tokens
      session[:access_token] = tokens[:access_token]
      session[:refresh_token] = tokens[:refresh_token]
    end

    puts "Access Token: " + tokens[:access_token]
    puts "Refresh Token: " + tokens[:refresh_token]

    redirect_to session[:return_url] || admin_root_path
  end

  private

  def callback_url
    url_for(action: :callback)
  end

  def auth_service
    @service ||= GoogleAuthService.new
  end
end
