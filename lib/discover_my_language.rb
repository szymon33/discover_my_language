# frozen_string_literal: true

require_relative 'services/github_service/repositories'

class DiscoverMyLanguage
  def initialize(user_name)
    @user_name = user_name
    @repositories = []
    @favourite_lang = nil
  end

  def build
    @repositories = GithubService::Repositories
                    .new.list_user_repositories(@user_name)
    return 'Error connecting GitHub' if @repositories.nil?
    return "No data about the user #{@user_name}" if @repositories.empty?
    evalutate_language
    "#{@user_name} favourite programming language is #{@favourite_lang}"
  end

  private

  def evalutate_language
    results = Hash.new(0)
    @repositories.each do |repo|
      langs = GithubService::Repositories
              .new.list_languages(@user_name, repo['name']) || []
      langs.each do |lang, bytes|
        results[lang] += bytes
      end
    end
    @favourite_lang = results.max_by { |_k, v| v }.first
  end
end
