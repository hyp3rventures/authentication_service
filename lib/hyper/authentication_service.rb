require 'json'
require 'faraday'
require 'hyper/authentication_service/connection'
require 'hyper/authentication_service/errors'
require 'hyper/authentication_service/request'
require 'hyper/authentication_service/version'

module Hyper
  module AuthenticationService
    AUTHENTICATION_BASE = 'https://app.hyp3r.co'
    AUTHENTICATION_PATH = '/api/v1/authentications/verify'
  end
end
