# frozen_string_literal: true

require_relative 'client'

module GithubService
  class Repositories < Client
    def list_user_repositories(user_name)
      url = "/users/#{ user_name }/repos"
      call_wrapper { self.class.get(url) }
    end

    def list_languages(owner, repo)
      # Lists languages for the specified repository. The value shown for
      # each language is the number of bytes of code written in that language.
      url = "/repos/#{owner}/#{ repo }/languages"
      call_wrapper { self.class.get(url) }
    end
  end
end
