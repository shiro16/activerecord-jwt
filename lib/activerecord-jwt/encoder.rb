module ActiveRecord::Jwt
  module Encoder
    module_function
    def self.configure(&block)
      yield(configuration)
    end

    def configuration
      @_configuration ||= EncoderConfiguration.new
    end

    def jwt
      JWT.encode(payload, ActiveRecord::Jwt::Encoder.configuration.key, ActiveRecord::Jwt::Encoder.configuration.algorithms)
    end

    private
    def payload
      {
        sub: self.id,
        exp: Time.now.to_i + ActiveRecord::Jwt::Encoder.configuration.exp,
        iss: ActiveRecord::Jwt::Encoder.configuration.iss,
        aud: ActiveRecord::Jwt::Encoder.configuration.aud,
        iat: Time.now.to_i,
        class: self.class.to_s
      }
    end
  end
end
