module ActiveRecord::Jwt
  module Decoder
    extend ActiveSupport::Concern

    module ClassMethods
      def find_authenticated_jwt(jwt)
        decoded_jwt = decode_jwt(jwt)
        self.find_by(self.primary_key => decoded_jwt[:payload]['sub'])
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
        raise ActiveRecord::Jwt::InvalidError.new if ActiveRecord::Jwt::Decoder.configuration.class && payload['class'] != self.name.to_s
      end
    end

    module_function
    def self.configure(&block)
      yield(configuration)
    end

    def configuration
      @_configuration ||= DecoderConfiguration.new
    end
  end
end
