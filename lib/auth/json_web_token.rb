module Auth
  class JsonWebToken
    class << self
      def encode(payload)
        jwt_payload = payload.reverse_merge meta
        JWT.encode(jwt_payload, key)
      end

      def decode(token)
        JWT.decode(
            token,
            key,
            false,
        )[0]
      end

      private

      def meta
        {
            exp: 4.hours.from_now.to_i,
        }
      end

      def key
        'thisisasecretkeyshhh'
      end
    end
  end
end
