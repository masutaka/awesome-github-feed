ENV['RACK_ENV'] = 'test'

require 'json'
require 'pry'
require 'rack/test'
require 'rspec'
require_relative '../app'

describe 'Sinatra App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe '/' do
    it 'is 404 Not Found' do
      get '/'
      expect(last_response.status).to eq 404
    end
  end

  describe '/masutaka.private.atom' do
    context 'given no token' do
      it 'is 404 Not Found' do
        get '/masutaka.private.atom'
        expect(last_response.status).to eq 404
      end
    end

    context 'given valid token' do
      before { get '/masutaka.private.atom', token: 'VALIDTOKEN' }

      it 'is 200 OK' do
        expect(last_response.status).to eq 200
      end

      it 'has the valid token' do
        expect(last_response.body).to include 'https://github.com/masutaka.private.atom?token=VALIDTOKEN'
      end
    end

    context 'given invalid token' do
      it 'is 404 Not Found' do
        get '/masutaka.private.atom', token: 'INVALIDTOKEN'
        expect(last_response.status).to eq 404
      end
    end
  end
end
