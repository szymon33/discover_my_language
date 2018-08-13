require 'spec_helper'
require 'discover_my_language'

describe DiscoverMyLanguage do
  it 'is test' do
    expect(described_class.new.playground).to eq 'hello world'
  end
end
