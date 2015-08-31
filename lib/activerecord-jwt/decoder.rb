module ActiveRecord::Jwt
  module Decoder
    module_function
    def self.configure(&block)
      yield(configuration)
    end

    def configuration
      @_configuration ||= DecoderConfiguration.new
    end

    module ClassMethods
      def find_authenticated_jwt(jwt)
        decoded_jwt = decode_jwt(jwt)
        self.find(self.primary_key => decoded_jwt[:payload]['sub'])
      end

      def decode_jwt(jwt)
        payload, header = JWT.decode(jwt, ActiveRecord::Jwt::Decoder.configuration.key, true, ActiveRecord::Jwt::Decoder.configuration.options)
        payload_valid?(payload)
        { payload: payload, header: header }
      rescue JWT::DecodeError => e
        raise ActiveRecord::Jwt::InvalidError.new(e)
      end

      private
      def payload_valid?(payload)
        raise ActiveRecord::Jwt::InvalidError.new if ActiveRecord::Jwt::Decoder.configuration.class && payload['class'] != self.class.to_s
      end
    end
  end
end
