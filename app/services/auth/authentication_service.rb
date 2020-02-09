module Auth
  class AuthenticationService
    class << self
      def login(params)
        @user = User.find_by(username: params[:username])
        
        return @user if @user.authenticate(params[:password])
        nil
      end
    end
  end
end
