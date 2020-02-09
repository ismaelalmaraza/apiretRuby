module Auth
  module Authenticate
    attr_reader :current_user

    def valid?
      bearer_header.present?
    end

    def authenticate!
      @current_user = User.find claims['id']
      raise StandardError unless @current_user
    end

    protected

    def bearer_header
      request.headers['Authorization']&.to_s
    end

    private

    def claims
      strategy, token = bearer_header.split(' ')
      raise StandardError unless (strategy || '').downcase == 'bearer'
      Auth::JsonWebToken.decode(token)
    end
  end
end
