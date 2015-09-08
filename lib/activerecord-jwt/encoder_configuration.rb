module ActiveRecord::Jwt
  class EncoderConfiguration
    attr_accessor :algorithm, :key, :exp, :iss, :aud

    def initialize
      self.algorithm = 'HS256'
      self.exp       = 600
      self.iss       = 'issuer'
      self.aud       = 'audience'
    end
  end
end
