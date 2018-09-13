# frozen_string_literal: true

require_relative 'services/github_service/repositories'

class DiscoverMyLanguage
  def initialize(user_name)
    @user_name = user_name
    @repositories = []
    @favourite_lang = nil
  end

  def build
    return 'please enter a usernmame' if @user_name.empty?

    fetch_list_of_repositories
    case true
    when @repositories.nil?
      'Error connecting GitHub'
    when @repositories.empty?
      "No data about the user #{@user_name}"
    else
      "#{@user_name} favourite programming language is #{favourite_lang(evalutate_language)}"
    end
  rescue ArgumentError
    'username not found'
  end

  private

  def evalutate_language
    @repositories.each_with_object(Hash.new(0)) do |repo, results|
      calculate_bytes(languages_from_github(repo), results)
    end
  end

  private

  def languages_from_github(repo)
    GithubService::Repositories
      .new.list_languages(@user_name, repo['name']) || []
  end

  def calculate_bytes(langs, results)
    langs.each do |lang, bytes|
      results[lang] += bytes
    end
  end

  def fetch_list_of_repositories
    @repositories = GithubService::Repositories
                    .new.list_user_repositories(@user_name)
  end

  def favourite_lang(hash)
    hash.max_by { |_k, v| v }.first
  end
end
