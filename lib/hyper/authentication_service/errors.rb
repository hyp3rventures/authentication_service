module Hyper
  module AuthenticationService
    class Error < StandardError; end
    class InvalidUserObjectError < Error; end
    class UnauthorizedUserError < Error; end
  end
end
