# frozen_string_literal: true

require 'spec_helper'
require 'services/github_service/client'

describe GithubService::Client do
  subject { described_class }

  it { respond_to(:get) }
end
