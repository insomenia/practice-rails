class Users::RefreshController < ApiController
  skip_before_action :authorize_access_request!
  before_action :authorize_refresh_by_access_request!

  def create
    session = JWTSessions::Session.new(payload: claimless_payload, refresh_by_access_allowed: true)
    tokens = session.refresh_by_access_payload
    render json: { csrf: tokens[:csrf], token: tokens[:access] }
  end
end
