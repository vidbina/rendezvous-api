require File.expand_path '../spec_helper.rb', __FILE__

describe "Rendezvous API" do
  it "should allow accessing the home page" do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to include('rendez')
  end

  it "should allow creation of encounters" do
    post '/encounters', { name: 'Lunch', token: '', friends: ['as@bina.me']}
  end
end

