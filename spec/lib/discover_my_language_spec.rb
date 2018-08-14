# frozen_string_literal: true

require 'spec_helper'
require 'discover_my_language'

describe DiscoverMyLanguage do
  let(:user_name) { 'szymon33' }

  it 'it is success' do
    expect(described_class.new(user_name).build).to eq "szymon33 favourite programming language is Ruby"
  end
end
