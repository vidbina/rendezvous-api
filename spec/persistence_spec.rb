require File.expand_path '../spec_helper.rb', __FILE__

describe 'Persistence layer' do
  let(:adaptor) { Object.new }

  it 'should be able to store user id if nonexistent' do
    expect(adaptor).to receive(:save_if_nonexistent).and_return(true)
    Persistence.new(adaptor).get_new_id_for_user 'Marcus' # met this guy in the hallway while writing this
  end

  it "should be able to get us a unique 32char user id" do
    expect(adaptor).to receive(:save_if_nonexistent).and_return(true)
    expect(Persistence.new(adaptor).get_new_id_for_user('Natascha').length).to eq(32)
  end

  it "should not be able to get an id " do
    expect(adaptor).to receive(:save_if_nonexistent).and_return(false).at_least(3).times
    expect(Persistence.new(adaptor).get_new_id_for_user('Natascha')).to eq(false)
  end

  it "should return true upon saving a value" do
    expect(adaptor).to receive(:save_and_possibly_overwrite).and_return(true)
    expect(Persistence.new(adaptor).save('test:0000', 'cool')).to eq(true)
  end

  it "should return false upon failing to save" do
    expect(adaptor).to receive(:save_and_possibly_overwrite).and_return(false)
    expect(Persistence.new(adaptor).save('test:0000', 'cool')).to eq(false)
  end
end
