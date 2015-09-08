require 'spec_helper'

class User < ActiveRecord::Base
      include ActiveRecord::Jwt::Encoder
end

describe ActiveRecord::Jwt::Encoder do
  let(:secret_key) { 'secret_key' }
  let(:algorithm) { 'HS256' }
  let(:user) { User.create(nickname: "test") }
  let(:payload) {
    {
      sub: user.nickname,
      exp: Time.now.to_i + 60,
      iss: 'issuer',
      aud: 'audience',
      iat: Time.now.to_i,
      class: User.name
    }
  }

  before do
    ActiveRecord::Jwt::Encoder.configure do |config|
      config.sub = :nickname
      config.key = secret_key
      config.algorithm = algorithm
      config.exp = 60
      config.iss = 'issuer'
      config.aud = 'audience'
    end
  end

  after { User.destroy_all }

  describe '#jwt' do
    let(:jwt) { JWT.encode(payload, secret_key, algorithm) }

    subject { user.jwt }

    it { expect(subject).to eq(jwt) }
  end

  describe '#payload' do
    subject { user.send(:payload) }

    it { expect(subject).to eq(payload) }
  end
end
