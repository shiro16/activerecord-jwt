module ActiveRecord::Jwt
  module Decoder
    module ClassMethods
      def find_authenticated_jwt(jwt)
        self.find(self.primary_key => decode_jwt(jwt))
      end

      def decode_jwt(jwt)
        payload, header = JWT.decode(jwt, ActiveRecord::Jwt::DecoderConfiguration.key, true, ActiveRecord::Jwt::DecoderConfiguration.options)
        payload_valid?(payload)
        payload['sub']
      end

      private
      def payload_valid?(payload)
        # TODO: check payload type
      end
    end
  end
end
