require 'signet/oauth_2/client'

class GoogleAuthService
  attr_reader :client_id, :client_secret

  def initialize(options={})
    @client_id = options[:client_id] || ENV.fetch('GOOGLE_API_CLIENT_ID')
    @client_secret = options[:client_secret] || ENV.fetch('GOOGLE_API_CLIENT_SECRET')
  end

  def client(options={})
    Signet::OAuth2::Client.new( oauth2_config.merge(options) )
  end

  def get_authorization_uri(redirect_uri:, scope:)
    client(redirect_uri: redirect_uri, scope: scope).authorization_uri.to_s
  end

  def fetch_tokens(redirect_uri:, scope:, code:)
    response = client(redirect_uri: redirect_uri, scope: scope, code: code).fetch_access_token!

    {
      access_token: response['access_token'],
      refresh_token: response['refresh_token']
    }
  end

  private

  def oauth2_config
    {
      client_id: client_id,
      client_secret: client_secret,
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      access_type: 'offline',
    }
  end
end
