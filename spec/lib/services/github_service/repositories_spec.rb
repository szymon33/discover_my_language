# frozen_string_literal: true

require 'spec_helper'
require 'services/github_service/repositories'

describe GithubService::Repositories do
  describe '.list_user_repositories' do
    let(:user_name) { 'szymon33' }

    it 'is nil with nil user name' do
      expect(subject.list_user_repositories(nil)).to eq nil
    end

    it 'calls get method' do
      expect(described_class).to receive(:get)
      subject.list_user_repositories('La La Land')
    end

    describe 'successful result' do
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

    describe 'failing result' do
      subject do
        described_class.new
                       .list_user_repositories('Enough is enough!')
      end

      it { is_expected.to be nil }
    end
  end
end
