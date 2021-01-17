class LogoutUser
    def initialize(token)
        puts "i m in logoutuser"
        @token = token
    end

    def call()
        puts "i m here"
        JsonWebToken.invalidate(token: token)
    end

    private 
    attr_reader :user_id

    def user
        puts "leitourgei pote?"
        user = User.find_by(email: email).id
        return user if user && user.logout(user_id)
        raise(ExceptionHandler::AuthenticationError, "sth went wrong")
    end
end
