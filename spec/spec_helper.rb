require 'rack/test'
require 'rspec'
require 'fakeredis'

require File.expand_path '../../app.rb', __FILE__

ENV['RACK_ENV'] = 'test'

module RSpecMixin
  include Rack::Test::Methods
  def app() RendezvousApi end
end

RSpec.configure { |c| c.include RSpecMixin }
