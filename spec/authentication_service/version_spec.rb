require 'spec_helper'

RSpec.describe Hyper::AuthenticationService do
  it 'has a version number' do
    expect(Hyper::AuthenticationService::VERSION).not_to be nil
  end
end
