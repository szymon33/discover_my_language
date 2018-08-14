# frozen_string_literal: true

require 'httparty'

module GithubService
  class Client
    include HTTParty

    base_uri 'api.github.com'
  end
end
