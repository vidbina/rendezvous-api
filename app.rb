require 'sinatra/base'

class RendezvousApi < Sinatra::Base
  get '/' do
    'Let\'s rendezvous'
  end
end
