module ActiveRecord::Jwt
  class DecoderConfiguration
    attr_accessor :algorithm, :key, :class, :exp, :iss, :aud, :iat, :sub

    def initialize

    end

    def options
      {
        algorithm: self.algorithm,
        verify_expiration: self.exp.present?,
        verify_iss: self.iss.present?,
        verify_aud: self.aud.present?,
        verify_iat: self.iat.present?,
        verify_sub: self.sub.present?,
        'iss' => self.iss,
        'aud' => self.aud,
        'sub' => self.sub
      }
    end
  end
end
