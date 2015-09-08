module ActiveRecord::Jwt
  class EncoderConfiguration
    attr_accessor :sub, :algorithm, :key, :exp, :iss, :aud

    def initialize
      self.sub       = :id
      self.algorithm = 'HS256'
      self.exp       = 600
      self.iss       = 'issuer'
      self.aud       = 'audience'
    end
  end
end
