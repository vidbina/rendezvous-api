class Messenger
end

class NexmoMessenger < Messenger
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

  def broadcast_encounter(params)
    numbers = ['686136392', '0618345454', '0619168586']
    numbers.each do |number|
      @client.send_message(
        to: number,
        type: 'text',
        text: "#{params[:what]} at #{params[:where]} #{params[:when]}. I've opted some dates https://api.example.com/#{SecureRandom.hex}"
      )
    end
  end
end
