class LogoutController < ApplicationController
    skip_before_action :authorize_request, only: :logout
  # return auth token once user is authenticated
  def logout
    
    #auth_token = request.headers['Authorization']
    
    
    @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
    p @current_user.id
    JsonWebToken.invalidate(@current_user.id)
    json_response({message: "You have succesfully logged out..."})
    # puts "finished"
    # p @current_user
    #u#ser  = LogoutUser.new(auth_params[:token])
    # p auth_params[:email]
    # p request.headers
      # dec_token = JsonWebToken.decode(:token)
      # p dec_token
      # json_response(message: "/Succesful Logout/")
    # else
    # json_response(message: "/Invalid credentials/")
    # end
  end

  
  private

  def auth_params
    params.permit(:Authorization)
  end
end
