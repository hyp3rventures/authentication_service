require 'bundler/setup'
require 'hyper/authentication_service'
require 'webmock/rspec'
require 'pry'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = 'spec/examples.txt'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.order = :random
  Kernel.srand config.seed

  config.disable_monkey_patching!
  config.filter_run_when_matching :focus
end
