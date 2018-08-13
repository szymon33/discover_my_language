require 'spec_helper'
require 'services/github_service/client'

describe GithubService::Client do
  it 'is test' do
    expect(described_class.new.playground).to eq 'test'
  end
end
