module ActiveRecord::Jwt
  module Encoder
    extend ActiveSupport::Concern

    def jwt
      JWT.encode(payload, ActiveRecord::Jwt::Encoder.configuration.key, ActiveRecord::Jwt::Encoder.configuration.algorithm)
    end

    private
    def payload
      {
        sub: self.send(ActiveRecord::Jwt::Encoder.configuration.sub),
        exp: Time.now.to_i + ActiveRecord::Jwt::Encoder.configuration.exp.to_i,
        iss: ActiveRecord::Jwt::Encoder.configuration.iss,
        aud: ActiveRecord::Jwt::Encoder.configuration.aud,
        iat: Time.now.to_i,
        class: self.class.to_s
      }
    end

    module_function
    def self.configure(&block)
      yield(configuration)
    end

    def configuration
      @_configuration ||= EncoderConfiguration.new
    end
  end
end
