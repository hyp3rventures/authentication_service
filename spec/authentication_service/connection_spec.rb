require 'spec_helper'

RSpec.describe Hyper::AuthenticationService::Connection do
  it { is_expected.to be_a(Faraday::Connection) }
end