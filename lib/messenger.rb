class Messenger
end

class NexmoMessenger < Messenger
  require 'nexmo'

  def initialize(key, secret)
    @key = key
    @secret = secret
    @client = Nexmo::Client.new(key: key, secret: secret)
  end

  def validate_numbers(numbers)
    numbers.filter do |number|
      #@client.number_search
    end
  end

  def broadcast_encounter(data)
    numbers = ['+31686136392', '+31619168586'] #, '+31618345454'
    numbers.each do |number|
      p data
      msg = {
        to: number,
        from: "the rendezvous api",
        type: 'text',
        text: "#{data[:what]} at #{data[:where]} #{data[:when]}. I've opted some dates https://api.example.com/#{SecureRandom.hex}"
      }
      p msg
      @client.send_message(msg)
    end
  end
end
