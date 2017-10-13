require 'spec_helper'

RSpec.describe Hyper::AuthenticationService::Connection do
  describe '.build' do
    let(:url) { 'https://example.com' }
    subject { described_class.build(url) }

    it { is_expected.to be_a(Faraday::Connection) }
  end
end
