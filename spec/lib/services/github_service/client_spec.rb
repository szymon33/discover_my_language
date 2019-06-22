# frozen_string_literal: true

require 'spec_helper'
require 'services/github_service/client'

describe GithubService::Client do
  subject { described_class }

  it { respond_to(:get) }

  describe '.initialize' do
    subject { described_class.new }

    it 'has no error' do
      expect(subject.errors).to be_empty
    end

    it 'has options as hash' do
      expect(subject.instance_variable_get(:@options)).to be_a Hash
    end
  end

  describe '.call_wrapper' do
    let(:request) { double('response', code: 200, success?: true, body: { a: :b }.to_json) }
    subject { described_class.new.send(:call_wrapper) { request } }

    it 'is something' do
      expect(subject).to eq({ a: 'b' })
    end
  end

  describe '.handle_error' do
    it 'is response body' do
      response = double(:response, code: 200, success?: false, body: { a: :b }.to_json )
      msg = described_class.new.send(:handle_error, response)
      expect(msg).to eq({ a: 'b' })
    end

    it 'is response' do
      response = double(:response, code: 200, success?: false, body: nil )
      msg = described_class.new.send(:handle_error, response)
      expect(msg).to eq ["#{ response }"]
    end
  end
end
