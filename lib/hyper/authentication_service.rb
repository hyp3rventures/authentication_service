require 'json'
require 'faraday'
require 'hyper/authentication_service/connection'
require 'hyper/authentication_service/errors'
require 'hyper/authentication_service/request'
require 'hyper/authentication_service/version'

module Hyper
  module AuthenticationService
    AUTHENTICATION_BASE = ENV.fetch('AUTHENTICATION_BASE') { 'https://app-staging.hyp3r.co' }
    AUTHENTICATION_PATH = ENV.fetch('AUTHENTICATION_PATH') { '/api/v1/authentications/verify' }
    AUTHENTICATION_URL  = [AUTHENTICATION_BASE, AUTHENTICATION_PATH].join
  end
end
