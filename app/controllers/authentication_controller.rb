class AuthenticationController < ApplicationController
  def login
    @user = User.find_by(username: params[:username])

    if !@user || !@user.authenticate(params[:password])
      render json: { error: 'Bad Login' }, status: :unauthorized
    else
      token = JWT.encode({ user_id: @user.id }, 'LitTerally AnyThing')

      render json: { token: token }, status: :created
    end
  end
end
