class DogsController < ApplicationController
  def create
    header = request.headers['Authorization']

    if !header
      render json: { error: 'no token' }, status: :unauthorized
    else
      begin
        token = header.split(' ')[1] # split header and take second array element
        secret = 'LitTerally AnyThing'
        payload = JWT.decode(token, secret)[0] # have to grab the first element of the array returned

        @user = User.find(payload['user_id']) # payload keys are strings
        @dog = Dog.create(name: params[:name])

        render json: { dog: @dogs }
      rescue
        render json: { error: 'Bad Token' }, status: :unauthorized
      end
    end
  end

  def index
    @dogs = Dog.all

    render json: { dogs: @dogs }
  end
end
