# frozen_string_literal: true

require 'httparty'

module GithubService
  class Client
    include HTTParty

    base_uri 'https://api.github.com'

    def initialize
      @options = {}
    end
  end
end
