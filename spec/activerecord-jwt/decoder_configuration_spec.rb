require 'spec_helper'

describe ActiveRecord::Jwt::DecoderConfiguration do
  context "default instance variable" do
    let(:config) { ActiveRecord::Jwt::DecoderConfiguration.new }

    it { expect(config.algorithm).to eq('HS256') }
    it { expect(config.class).to be_truthy }
    it { expect(config.exp).to be_truthy }
    it { expect(config.iss).to eq('issuer') }
    it { expect(config.aud).to eq('audience') }
    it { expect(config.iat).to be_truthy }
    it {
      expect(config.options).to eq({
        algorithm: 'HS256',
        verify_expiration: true,
        verify_iss: true,
        verify_aud: true,
        verify_iat: true,
        'iss' => 'issuer',
        'aud' => 'audience'
      })
    }
  end
end
