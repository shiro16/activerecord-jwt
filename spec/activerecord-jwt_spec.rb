require 'spec_helper'

describe Activerecord::Jwt do
  it 'has a version number' do
    expect(Activerecord::Jwt::VERSION).not_to be nil
  end
end
