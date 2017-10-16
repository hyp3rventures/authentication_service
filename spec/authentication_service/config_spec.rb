require 'spec_helper'

RSpec.describe Hyper::AuthenticationService::Config do
  it { is_expected.to respond_to(:base, :path, :url) }

  describe 'default values' do
    describe 'base' do
      it "equals 'https://app.hyp3r.co'" do
        expect(subject.base).to eq('https://app.hyp3r.co')
      end
    end

    describe 'path' do
      it "equals '/api/v1/authentications/verify'" do
        expect(subject.path).to eq('/api/v1/authentications/verify')
      end
    end
  end
end
