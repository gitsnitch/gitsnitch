require './spec/rails_helper'

describe 'OctokitSearch' do

  before do
    @repo_search = OctokitSearch.new('BigBerta')
    @repo_search.search_manager
    octokit_response = ResponseStub.new
    @url = octokit_response.url
    @raw = octokit_response.raw
    @fragment = octokit_response.fragment
  end

  describe 'initialize' do

    it 'sets username' do
      expect(instance_variable(:@username)).to eq('BigBerta')
    end

  end

  describe 'final results' do

    it 'returns the confirmed results' do
      expect(instance_variable(:@results_final)[0][:url]).to eq(@url)
    end

    it 'returns the confirmed results' do
      expect(instance_variable(:@results_final)[0][:raw]).to eq(@raw)
    end

    it 'returns the confirmed results' do
      expect(instance_variable(:@results_final)[0][:fragment]).to eq(@fragment)
    end

  end

private

  def instance_variable(variable)
    @repo_search.instance_variable_get(variable)
  end

end
