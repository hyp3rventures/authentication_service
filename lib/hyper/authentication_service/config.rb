module Hyper
  module AuthenticationService
    class Config
      AUTHENTICATION_BASE = 'https://app.hyp3r.co'
      AUTHENTICATION_PATH = '/api/v1/authentications/verify'

      attr_writer :base, :path

      def base
        @base ||= AUTHENTICATION_BASE
      end

      def path
        @path ||= AUTHENTICATION_PATH
      end

      def url
        "#{base}#{path}"
      end
    end
  end
end
