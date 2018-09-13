# frozen_string_literal: true

require 'spec_helper'
require 'services/github_service/repositories'

describe GithubService::Repositories do
  describe '.list_user_repositories' do
    let(:user_name) { 'szymon33' }

    it 'calls get method' do
      expect(described_class).to receive(:get)
      allow_any_instance_of(described_class).to receive(:handle_error).and_return(nil)
      subject.list_user_repositories('La La Land')
    end

    describe 'successful result', vcr: true do
      subject { described_class.new.list_user_repositories(user_name) }

      it 'is an array' do
        expect(subject).to be_a Array
      end

      describe 'JSON' do
        subject { described_class.new.list_user_repositories(user_name).first }

        it { is_expected.to include('name') }
        it { is_expected.to include('owner') }
      end
    end

    it 'failing result' do
      expect {
        described_class.new
                       .list_user_repositories('Enough is enough!')
      }.to raise_error(StandardError)
    end
  end

  describe '.list_languages', vcr: true do
    let(:owner) { 'szymon33' }
    let(:repo) { 'discover_my_language' }

    it 'calls get method' do
      expect(described_class).to receive(:get)
      subject.list_languages(owner, repo)
    end

    describe 'successful result' do
      subject { described_class.new.list_languages(owner, repo) }

      it 'is an array' do
        expect(subject).to be_a Hash
      end

      describe 'JSON' do
        subject { described_class.new.list_languages(owner, repo) }

        it { is_expected.to include 'Ruby' }
      end
    end

    describe 'failing result' do
      subject do
        described_class.new
                       .list_languages("I cycle every day - it's OK", repo)
      end

      it { is_expected.to be nil }
    end
  end
end
