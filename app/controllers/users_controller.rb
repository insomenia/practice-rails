class UsersController < ApiController

  def create
    user = User.new(signup_params)
    user.uuid = sub
    byebug
    user.save!
  end

  def create_user
    password = SecureRandom.hex(10)
    user = User.create(email: "api-#{SecureRandom.hex(4)}@practice.com", password: password, password_confirmation: password)
    render json: serialize(user)
  end

  def me
    render json: serialize(current_api_user)
  end

  private

  def signup_params
    params.require(:user).permit(User::USER_COLUMNS)
  end

end
