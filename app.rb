require 'sinatra/base'
require 'sinatra/json'

require File.expand_path '../lib/persistence.rb', __FILE__
require File.expand_path '../lib/adaptor.rb', __FILE__

class RendezvousApi < Sinatra::Base
  store = Persistence.new(RedisAdaptor.new(nil, Redis.new))

  get '/' do
    'Let\'s rendezvous'
  end

  get '/id' do
    store.get_new_user_id("Name")
  end

  post '/encounters' do
    source = params
    id = nil
    3.times do
      id = SecureRandom.hex
      store.save("encounter:#{id}", {
        email: source[:email],
        title: source[:title],
        date:  source[:date],
        location: source[:location],
        members: source[:members]
      }, ttl=3600)
    end
    json id: id
  end

  get '/encounters/:id' do
    json store.get("encounter:#{params[:id]}")
  end
end
