# frozen_string_literal: true

require_relative 'services/github_service/repositories'

class DiscoverMyLanguage
  def initialize(user_name)
    @user_name = user_name
    @repositories = []
  end

  def build
    return 'please enter a usernmame' if @user_name.empty?

    @repositories, errors = fetch_list_of_repositories
    case
    when errors.any?
      errors.join(',')
    when @repositories.empty?
      "No data about the user #{@user_name}"
    else
      "#{ @user_name } favourite programming language is #{ find_favourite_lang }"
    end
  end

  private

  def evaluate_languages
    @repositories.each_with_object(Hash.new(0)) do |repo, results|
      calculate_bytes(languages_from_github(repo), results)
    end
  end

  private

  def languages_from_github(repo)
    GithubService::Repositories
      .new.list_languages(@user_name, repo[:name]) || []
  end

  def calculate_bytes(langs, results)
    langs.each do |lang, bytes|
      results[lang] += bytes
    end
  end

  def fetch_list_of_repositories
    client = GithubService::Repositories.new
    list = client.list_user_repositories(@user_name)
    [list, client.errors]
  end

  def find_favourite_lang
    evaluate_languages.max_by { |_k, v| v }.first
  end
end
