class AuthenticationController < ApplicationController
  def login
    @user = User.find_by(username: params[:username])

    if !@user || !@user.authenticate(params[:password])
      render json: { error: 'Bad Login' }, status: :unauthorized
    else
      token = JWT.encode({ user_id: @user.id }, Rails.application.secret_key_base)

      render json: { token: token }, status: :created
    end
  end
end
