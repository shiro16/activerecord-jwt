module ActiveRecord::Jwt
  module Encode
    def jwt
      JWT.encode(payload, ActiveRecord::Jwt::EncodeConfiguration.key, ActiveRecord::Jwt::EncodeConfiguration.algorithms)
    end

    private
    def payload
      {
        sub: self.id,
        exp: Time.now.to_i + ActiveRecord::Jwt::EncodeConfiguration.exp,
        nbf: TIme.now.to_i + ActiveRecord::Jwt::EncodeConfiguration.ndf,
        iss: ActiveRecord::Jwt::EncodeConfiguration.iss,
        aud: ActiveRecord::Jwt::EncodeConfiguration.aud,
        iat: Time.now.to_i,
        type: self.class.to_s
      }
    end
  end
end
