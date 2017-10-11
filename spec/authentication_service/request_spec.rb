require 'spec_helper'

RSpec.describe Hyper::AuthenticationService::Request do
  let(:user) do
    { :id => 1, :email => 'user@example.com', :authentication_token => '1234abcd' }
  end
  let(:headers) do
    { 'X-Entity-Token' => user[:authentication_token], 'X-Entity-Email' => user[:email] }
  end
  let(:authentication_url) { Hyper::AuthenticationService::AUTHENTICATION_URL }
  let(:connection) { Hyper::AuthenticationService::Connection.new }
  let(:status) { { status: 200, body: user.to_json } }

  subject { described_class.new }

  before do
    allow(connection).to receive(:post).and_call_original
    allow(subject).to receive(:connection).and_return(connection)
    stub_request(:post, authentication_url)
      .to_return(status)
  end

  describe '#run' do
    it { is_expected.to respond_to(:run) }

    context 'with well-formed user object' do
      it 'makes a request to the authentication url' do
        subject.run(user)
        expect(connection).to have_received(:post)
      end
    end

    context 'without well-formed user object' do
      let(:user) { { :name => 'Anakin Skywalker', :is_jedi_master => false } }

      it 'raises an InvalidUserError' do
        expect { subject.run(user) }.to raise_error(Hyper::AuthenticationService::InvalidUserError)
      end
    end
  end

  describe '#user' do
    it { is_expected.to respond_to(:user) }

    context 'when user has not made request yet' do
      it 'returns an empty hash' do
        expect(subject.user).to eq({})
      end
    end

    context 'when run with well-formed user object' do
      before do
        subject.run(user)
      end

      context 'when successful' do
        let(:result) {
          {
            'email' => user[:email],
            'authentication_token' => user[:authentication_token],
            'id' => user[:id]
          }
        }
        it 'returns a user hash' do
          expect(subject.user).to eq(result)
        end
      end

      context 'when unsuccessful' do
        let(:result) { { 'error' => 'Invalid user or token' } }
        let(:status) { { status: 401, body: result.to_json } }

        it 'returns an error object' do
          expect(subject.user).to eq(result)
        end
      end
    end
  end

  describe 'response' do
    it { is_expected.to respond_to(:response) }

    describe 'before running' do
      it 'is nil' do
        expect(subject.response).to be_nil
      end
    end

    describe 'after running' do
      it 'is a Faraday response object' do
        expect { subject.run(user) }.to change { subject.response }.from(nil).to(Faraday::Response)
      end
    end
  end
end
