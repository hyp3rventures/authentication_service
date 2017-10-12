module Hyper
  module AuthenticationService
    class Request
      attr_reader :connection, :response

      def initialize
        @connection = Connection.new
      end

      def run(user)
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
          'X-Entity-Token' => user.fetch(:authentication_token),
          'X-Entity-Email' => user.fetch(:email)
        }
      end
    end
  end
end
