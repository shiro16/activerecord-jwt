module ActiveRecord::Jwt
  class EncoderConfiguration
    attr_accessor :algorithm, :key, :exp, :iss, :aud

    def initialize

    end
  end
end
