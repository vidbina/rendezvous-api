require File.expand_path '../spec_helper.rb', __FILE__

describe "Messenger" do
  it "sends messages" do
    NexmoMessenger.new('627d4974', '5e2ea448').broadcast_encounter(
      what: "Let's grab some drinks",
      where: "X",
      when: "next week",
      from: 'the api'
    )
    p "ok"
  end
end
