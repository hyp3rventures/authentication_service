require 'json'
require 'faraday'
require 'hyper/authentication_service/connection'
require 'hyper/authentication_service/errors'
require 'hyper/authentication_service/request'
require 'hyper/authentication_service/version'
require 'hyper/authentication_service/config'

module Hyper
  module AuthenticationService
    class << self
      def new(block = nil)
        if block_given?
          Request.new(&block)
        else
          Request.new
        end
      end
    end
  end
end
