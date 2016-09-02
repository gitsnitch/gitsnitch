require 'spec_helper'

feature 'External request' do
  it 'queries GitSnitch contributors on GitHub' do
    uri = URI('https://api.github.com/repos/gitsnitch/gitsnitch/contributors')

    response = Net::HTTP.get(uri)

    expect(response).to be_an_instance_of(String)
  end
end
