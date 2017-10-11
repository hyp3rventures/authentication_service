module Hyper
  module AuthenticationService
    class Request
      attr_reader :connection, :response

      def initialize
        @connection = Connection.new
      end

      def run(user)
        user.fetch(:email) && user.fetch(:authentication_token)
        @response = connection.post(AUTHENTICATION_PATH, nil, headers_for(user))
      rescue KeyError => e
        raise InvalidUserError, e.message
      end

      def user
        @user ||= response ? JSON.parse(response.body) : {}
      end

      private

      def headers_for(user)
        {
          'X-Entity-Token' => user[:authentication_token],
          'X-Entity-Email' => user[:email]
        }
      end
    end
  end
end
