class LogoutUser
    def initialize(token)
        @token = token
    end

    def call()
        JsonWebToken.invalidate(token: token)
    end

    private 
    attr_reader :user_id

    def user
       
        user = User.find_by(email: email).id
        return user if user && user.logout(user_id)
        raise(ExceptionHandler::AuthenticationError, "Something went wrong")
    end
end
