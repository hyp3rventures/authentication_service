module Hyper
  module AuthenticationService
    class Connection
      def self.new(authentication_base)
        Faraday.new(authentication_base)
      end
    end
  end
end
