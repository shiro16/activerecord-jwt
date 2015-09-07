require 'spec_helper'

class User < ActiveRecord::Base
    include ActiveRecord::Jwt::Decoder
end

describe ActiveRecord::Jwt::Decoder do
  let(:secret_key) { 'secret_key' }
  let(:algorithm) { 'HS256' }
  let(:user) { User.create(nickname: "test") }
  let(:payload) {
    {
      'sub' => user.id,
      'iss' => 'issuer',
      'aud' => 'audience',
      'class' => User.name
    }
  }
  let(:authenticate_jwt) { JWT.encode(payload, secret_key, algorithm) }

  before do
    ActiveRecord::Jwt::Decoder.configure do |config|
      config.key       = secret_key
      config.algorithm = algorithm
      config.class     = true
    end
  end

  describe '.find_authenticated_jwt' do
    context 'when authenticate jwt' do
      subject { User.find_authenticated_jwt(authenticate_jwt) }
      it { expect(subject.id).to eq user.id }
    end

    context 'when unauthenticate jwt' do
      subject { User.find_authenticated_jwt("test") }
      it { expect{ subject }.to raise_error(ActiveRecord::Jwt::InvalidError) }
    end

    context 'when find_by record not found' do
      subject { User.find_authenticated_jwt(authenticate_jwt) }
      before do
        user.destroy
      end
      it { expect(subject).to be_nil }
    end
  end

  describe '.decode_jwt' do
    context 'when authenticate jwt' do
      subject { User.decode_jwt(authenticate_jwt) }
      it { expect(subject[:payload]).to eq payload }
      it { expect(subject[:header]).to eq({'alg' => 'HS256', 'typ' => 'JWT'}) }
    end

    context  'when unauthenticate jwt' do
      subject { User.decode_jwt('test') }
      it { expect{ subject }.to raise_error(ActiveRecord::Jwt::InvalidError) }
    end
  end

  describe '.payload_valid?' do
    subject { User.send(:payload_valid?, payload) }

    context 'when same class' do
      it { expect(subject).to be_nil }
    end

    context 'when configuration class is false' do
      before do
        ActiveRecord::Jwt::Decoder.configuration.class = false
        payload['class'] = 'test'
      end

      it { expect(subject).to be_nil }
    end

    context 'when not the some class' do
      before do
        payload['class'] = 'test'
      end

      it { expect{ subject }.to raise_error(ActiveRecord::Jwt::InvalidError) }
    end
  end
end
