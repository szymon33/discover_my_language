# frozen_string_literal: true

require_relative 'client'

module GithubService
  class Repositories < Client
    def list_user_repositories(user_name)
      url = "/users/#{user_name}/repos"
      begin
        response = self.class.get(url, @options)
      rescue StandardError
        raise StandardError, 'Unexpected standard error'
      end
      response&.success? ? JSON.parse(response.body) : handle_error(response)
    end

    def list_languages(owner, repo)
      # Lists languages for the specified repository. The value shown for
      # each language is the number of bytes of code written in that language.
      url = "/repos/#{owner}/#{repo}/languages"
      begin
        response = self.class.get(url, @options)
        response&.success? ? JSON.parse(response.body) : nil
      rescue StandardError
        nil
      end
    end

    private

    def handle_error(response)
      raise 'Problem with connection' if response.nil?
      case response.code
      when 404
        raise ArgumentError, 'username not found'
      else
        raise 'Unexpected error'
      end
    end
  end
end
