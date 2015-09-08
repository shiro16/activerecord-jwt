module ActiveRecord::Jwt
  class DecoderConfiguration
    attr_accessor :sub, :algorithm, :key, :class, :exp, :iss, :aud, :iat

    def initialize
      self.sub       = :id
      self.algorithm = 'HS256'
      self.class     = true
      self.exp       = true
      self.iss       = 'issuer'
      self.aud       = 'audience'
      self.iat       = true
    end

    def options
      {
        algorithm:         self.algorithm,
        verify_expiration: self.exp.present?,
        verify_iss:        self.iss.present?,
        verify_aud:        self.aud.present?,
        verify_iat:        self.iat.present?,
        'iss' => self.iss,
        'aud' => self.aud
      }
    end
  end
end
