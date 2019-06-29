# frozen_string_literal: true

require 'spec_helper'
require 'discover_my_language'

describe DiscoverMyLanguage do

  describe '.build' do
    subject { described_class.new(user_name).build }

    context 'user name exist', vcr: true do
      let(:user_name) { 'szymon33' }

      it 'is success' do
        expect(subject)
          .to eq 'szymon33 favourite programming language is Ruby'
      end
    end

    context 'user name is empty' do
      let(:user_name) { '' }

      it "return error message 'please enter a usernmame' " do
        expect(subject)
          .to eq 'please enter a usernmame'
      end
    end

    context 'user name does not exist', vcr: true do
      let(:user_name) { 'admin' }

      it "return error message 'usernmame not found' " do
        expect(subject)
          .to eq 'Error: Not Found'
      end
    end

    context 'user name has no public repositories', vcr: true do
      let(:user_name) { 'fonixphil' }

      it "return error message 'usernmame not found' " do
        expect(subject)
          .to eq 'No data about the user fonixphil'
      end
    end
  end
end
