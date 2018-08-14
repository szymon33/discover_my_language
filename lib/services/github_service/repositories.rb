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
  end
end
