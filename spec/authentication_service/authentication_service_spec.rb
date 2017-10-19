require 'spec_helper'

RSpec.describe Hyper::AuthenticationService do
  describe '.new' do
    subject { Hyper::AuthenticationService.new }

    it 'is a Request object' do
      expect(subject).to be_a(Hyper::AuthenticationService::Request)
    end

    context 'with a block' do
      let(:block) { Proc.new { |config| config.base = 'https://example.com' } }
      subject { Hyper::AuthenticationService.new(&block) }

      it 'sets the connection values correctly' do
        expect(subject.send(:config).base).to eq('https://example.com')
      end
    end
  end
end
