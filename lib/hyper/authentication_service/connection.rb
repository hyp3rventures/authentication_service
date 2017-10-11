module Hyper
  module AuthenticationService
    class Connection
      def self.new
        Faraday.new(AUTHENTICATION_BASE)
      end
    end
  end
end
