class UsersController < ApiController

  def create
    user = User.new(signup_params)
    user.uuid = sub
    user.save!
  end

  def me
    render json: serialize(current_api_user)
  end

  private

  def signup_params
    params.require(:user).permit(User::USER_COLUMNS)
  end

end
