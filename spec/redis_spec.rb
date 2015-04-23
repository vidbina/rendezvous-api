require File.expand_path '../spec_helper.rb', __FILE__

describe 'Redis Adaptor' do
  let(:test_redis) { Redis.new }
  let(:adaptor) { RedisAdaptor.new(nil, test_redis) }

  before(:each) do
    test_redis.flushdb
  end
  it "sets values" do
    expect(adaptor.save_and_possibly_overwrite('overwritable', 'haha')).to eq(true)
  end

  it "breaks if item already set" do
    expect(adaptor.save_and_possibly_overwrite('saving_something', 'hi')).to eq(true)
    expect(adaptor.save_if_nonexistent('saving_something', 'oops')).to eq(false)
  end

  it "gets nonexistent values" do
    expect(adaptor.get('nothing')).to eq(nil)
  end

  it "gets nonexistent values" do
    expect(adaptor.save_and_possibly_overwrite('something', 'Westergasfabriek')).to eq(true)
    expect(adaptor.get('something')).to eq('Westergasfabriek')
  end

  context "used under the Persistence layer" do
    let(:storage) { Persistence.new(adaptor) }

    it ""
  end
end
