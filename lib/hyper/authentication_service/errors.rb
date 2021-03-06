module Hyper
  module AuthenticationService
    class Error < StandardError; end
    class InvalidUserObjectError < Error; end
    class UnauthorizedUserError < Error; end
    class InternalServerError < Error; end
  end
end
