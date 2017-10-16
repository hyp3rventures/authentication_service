module Hyper
  module AuthenticationService
    class Request
      def initialize
        @config = Config.new
        yield @config if block_given?
        @connection = Connection.new(config.base)
      end

      def run(user)
        response = connection.post(config.path, nil, headers_for(user))
        if response.body['error']
          raise UnauthorizedUserError, response.body['error']
        end
        response
      end

      private

      attr_reader :connection, :config

      def headers_for(user)
        {
          'X-Entity-Token' => user.fetch(:authentication_token),
          'X-Entity-Email' => user.fetch(:email)
        }
      rescue KeyError => e
        raise InvalidUserObjectError, e.message
      end
    end
  end
end
