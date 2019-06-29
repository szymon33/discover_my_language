# frozen_string_literal: true

require 'httparty'

module GithubService
  class Client
    attr_reader :errors

    include HTTParty

    base_uri 'https://api.github.com'

    def initialize
      @options = {}
      @errors = []
    end

    private

    def call_wrapper
      begin
        response = yield
      rescue
        handle_error(response) && return
      end
      handle_error(response)
      if response&.success? && response.code == 200
        JSON.parse(response.body, symbolize_names: true)
      else
        nil
      end
    end

    def handle_error(response)
      @errors = if response.nil?
                  ["Problem with connection"]
                elsif response.success?
                  if response.code == 200
                    []
                  elsif response.code == 404
                    ['username not found']
                  elsif response.body
                    json = JSON.parse(response.body, symbolize_names: true)
                    json.fetch(:errors, json)
                  end
                elsif response.message
                  ["Error: #{ response.message }"]
                else
                  ["#{ response }"]
                end
    end
  end
end
