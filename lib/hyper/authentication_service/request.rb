module Hyper
  module AuthenticationService
    class Request
      attr_reader :connection, :response, :config

      def initialize
        @config = Config.new
        yield config if block_given?
        @connection = Connection.new(config.base)
      end

      def run(user)
        @response = connection.post(config.path, nil, headers_for(user))
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
