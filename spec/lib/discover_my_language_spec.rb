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
          .to eq 'username not found'
      end
    end
  end
end
