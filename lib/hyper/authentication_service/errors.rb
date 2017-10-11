module Hyper
  module AuthenticationService
    class Error < StandardError; end
    class InvalidUserError < Error; end
  end
end
