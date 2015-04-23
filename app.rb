require 'sinatra/base'
require 'sinatra/json'

require File.expand_path '../lib/persistence.rb', __FILE__
require File.expand_path '../lib/adaptor.rb', __FILE__
require File.expand_path '../lib/messenger.rb', __FILE__

class RendezvousApi < Sinatra::Base
  store = Persistence.new(RedisAdaptor.new(nil, Redis.new(url: ENV['REDIS_URL'])))

  get '/' do
    'Let\'s rendezvous'
  end

  get '/id' do
    store.get_new_user_id("Name")
  end

  post '/encounters' do
    source = params
    id = nil
    begin
      3.times do
        id = SecureRandom.hex
        p "members are #{source[:members]}"
        store.save("encounter:#{id}", {
          email: source[:email],
          title: source[:title],
          date:  source[:date],
          location: source[:location],
          members: source[:members].join(',')
        }, ttl=3600)
      end
      json id: id
    rescue => e
      json error: 500, msg: 'i just shat myself'
    end
  end

  get '/encounters/:id' do
    begin
      json store.get("encounter:#{params[:id]}")
    rescue => e
      json error: 500, msg: 'sloppy work on my end, sawry'
    end
  end

  get '/send_messages' do
    begin
      NexmoMessenger.new(ENV['NEXMO_KEY'], ENV['NEXMO_SECRET']).broadcast_encounter(
        from: "the rendezvous api",
        what: "Let's grab some drinks",
        where: "X",
        when: "next week"
      )
      json msg: "messages sent"
    rescue
      json error: 500
    end
  end
end
