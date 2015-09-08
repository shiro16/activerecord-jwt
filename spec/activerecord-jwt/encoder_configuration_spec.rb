require 'spec_helper'

describe ActiveRecord::Jwt::EncoderConfiguration do
  context "default instance variable" do
    let(:config) { ActiveRecord::Jwt::EncoderConfiguration.new }

    it { expect(config.algorithm).to eq('HS256') }
    it { expect(config.exp).to eq(600) }
    it { expect(config.iss).to eq('issuer') }
    it { expect(config.aud).to eq('audience') }
  end
end
