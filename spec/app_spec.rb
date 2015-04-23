require File.expand_path '../spec_helper.rb', __FILE__

describe "Rendezvous API" do
  it "should allow accessing the home page" do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to include('rendez')
  end

  it "should allow creation encounters" do
    post '/encounters', { name: 'Lunch', token: '', friends: ['as@bina.me']}
    expect(last_response).to be_ok
    p(last_response.body)
  end

  it "should allow recall of encounters" do
    post '/encounters', { what: 'Gino is coding' }
    id = JSON.parse(last_response.body)["id"]
    get "/encounters/#{id}"
    expect(last_response).to be_ok
    p(last_response.body)
  end
end

