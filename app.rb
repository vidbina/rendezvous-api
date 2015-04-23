require 'sinatra/base'
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
end
