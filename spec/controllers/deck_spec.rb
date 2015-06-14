require_relative '../spec_helper'

describe 'Canary Test' do
  it 'should be a canary in a coal mine' do
    expect(true).to be(true)
  end
end

describe 'my sinatra application' do
  it 'should allow accessing the homepage' do
    get '/'
    expect(last_response).to be_ok
  end

  it "renders the login template" do
     get '/login'
     expect(last_response).to be_ok
  end
end
