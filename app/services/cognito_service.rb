class CognitoService
  attr_accessor :client, :identity_client

  def initialize
    @client = Aws::CognitoIdentityProvider::Client.new
    
    # (
    #   region: "local",
    #   access_key_id: "local",
    #   secret_access_key: "local",
    #   endpoint: "http://localhost:9229"
    # )
  end

  def sign_in
    user_object = {
      USERNAME: params[:username],
      PASSWORD: params[:password]
    }
    begin
      resp = authenticate(user_object).authentication_result
      render json: { result: resp.to_hash }, status: :ok
    rescue StandardError => e
      resp = e
    end
  end

  def create_user(username, password, user_attributes)
    # "test01@insomenia.com", "123123", [{name: "email", value: "test01@insomenia.com"}])
    auth_object = {
      client_id: "global_default_client_id",
      username: username,
      password: password,
      user_attributes: user_attributes
    }
    client.sign_up(auth_object)
  end

  def authenticate(user_object)
    auth_object = {
      user_pool_id: ENV["AWS_COGNITO_POOL_ID"],
      client_id: ENV["AWS_COGNITO_APP_CLIENT_ID"],
      auth_flow: "ADMIN_NO_SRP_AUTH",
      auth_parameters: user_object
    }
    @client.admin_initiate_auth(auth_object)
  end
end
