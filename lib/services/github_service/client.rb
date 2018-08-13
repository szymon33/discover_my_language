require 'httparty'

module GithubService
  class Client
    include HTTParty

    base_uri 'api.github.com'

    def playground
      'test'
    end
  end
end
