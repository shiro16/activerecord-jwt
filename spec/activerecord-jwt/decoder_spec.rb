require 'spec_helper'

class User < ActiveRecord::Base
    include ActiveRecord::Jwt::Decoder
end

describe ActiveRecord::Jwt::Decoder do
  describe '.find_authenticated_jwt' do
  end

  describe '.decode_jwt' do
  end

  describe '.payload_valid?' do
  end
end
