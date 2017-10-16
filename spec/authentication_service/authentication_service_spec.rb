require 'spec_helper'

RSpec.describe Hyper::AuthenticationService do
  describe '.new' do
    subject { Hyper::AuthenticationService.new }

    it 'is a Request object' do
      expect(subject).to be_a(Hyper::AuthenticationService::Request)
    end
  end
end
