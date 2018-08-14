# frozen_string_literal: true

require 'services/github_service/client'

module GithubService
  class Repositories < Client
    def list_user_repositories(user_name)
      return unless user_name
      url = "/users/#{user_name}/repos"
      begin
        response = self.class.get(url)
        response&.success? ? JSON.parse(response.body) : nil
      rescue StandardError
        nil
      end
    end

    def list_languages(owner, repo)
      # Lists languages for the specified repository. The value shown for
      # each language is the number of bytes of code written in that language.
      url = "/repos/#{owner}/#{repo}/languages"
      begin
        response = self.class.get(url)
        response&.success? ? JSON.parse(response.body) : nil
      rescue StandardError
        nil
      end
    end
  end
end
