require 'spec_helper'

RSpec.describe Hyper::AuthenticationService::Request do
  let(:user) { { :id => 1, :email => 'user@example.com', :authentication_token => '1234abcd' } }
  let(:headers) { { 'X-Entity-Token' => user[:authentication_token], 'X-Entity-Email' => user[:email] } }
  let(:config) { Hyper::AuthenticationService::Config.new }
  let(:connection) { Hyper::AuthenticationService::Connection.new(config.base) }
  let(:status) { { status: 200, body: user.to_json } }

  subject { described_class.new }

  before do
    allow(connection).to receive(:post).and_call_original
    allow(subject).to receive(:connection).and_return(connection)
    stub_request(:post, config.url)
      .to_return(status)
  end

  describe 'initialization' do
    before do
      allow(subject).to receive(:config).and_return(config)
    end
    context 'with a block' do
      let(:url) { 'http://example.com' }
      let(:config_block) { Proc.new { |c| c.base = url } }

      it 'sets the url base to the given url' do
        instance = described_class.new(&config_block)
        expect(instance.send(:config).base).to eq(url)
      end
    end

    context 'without a block' do
      it 'sets the url base to a default value' do
        instance = described_class.new
        expect(instance.send(:config).base).to eq(Hyper::AuthenticationService::Config::AUTHENTICATION_BASE)
      end
    end
  end

  describe '#run' do
    it { is_expected.to respond_to(:run) }

    context 'with well-formed user object' do
      context 'when successful' do
        let(:result) {
          {
            'email' => user[:email],
            'authentication_token' => user[:authentication_token],
            'id' => user[:id]
          }
        }

        it 'returns a response object' do
          response = subject.run(user)
          expect(connection).to have_received(:post)
          user_response = JSON.parse(response.body)
          expect(user_response).to eq(result)
        end
      end

      context 'when unsuccessful' do
        let(:result) { { 'error' => 'Invalid user or token' } }
        let(:status) { { status: 401, body: result.to_json } }

        it 'raises an UnauthorizedUserError' do
          expect { subject.run(user) }.to raise_error(Hyper::AuthenticationService::UnauthorizedUserError)
        end
      end
    end

    context 'without well-formed user object' do
      let(:user) { { :name => 'Anakin Skywalker', :is_jedi_master => false } }

      it 'raises an InvalidUserObjectError' do
        expect { subject.run(user) }.to raise_error(Hyper::AuthenticationService::InvalidUserObjectError)
      end
    end
  end
end
