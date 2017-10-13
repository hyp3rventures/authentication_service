module Hyper
  module AuthenticationService
    class Connection
      def self.build(authentication_base)
        Faraday.new(authentication_base)
      end
    end
  end
end
