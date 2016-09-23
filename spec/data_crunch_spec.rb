require './spec/rails_helper'

describe 'octokit_results' do

  before do
    octokit_response = ResponseStub.new
    @octokit_results = OctokitResults.new
    @octokit_results.extract(octokit_response.valid.pop)
    @url = octokit_response.url
    @raw = octokit_response.raw
    @fragment = octokit_response.fragment
    @trimmed_text = octokit_response.trimmed_text
    @string = @octokit_results.trim(octokit_response.secret_valid)
    @object = octokit_response.valid.pop[:items][0]
  end


  describe 'final instance variables' do

    it 'captures the correct url and saves it' do
      expect(instance_variable(:@data_url)).to eq(@url)
    end

    it 'captures the correct fragment and saves it' do
      expect(instance_variable(:@data_fragment)).to eq(@fragment)
    end

    it 'captures the correctly composes raw url and saves it' do
      expect(instance_variable(:@data_raw)).to eq(@raw)
    end

  end

  describe 'results_capture' do

    it 'captures data into a hash' do
      expect(instance_variable(:@results_final)[0]).to be_instance_of(Hash)
    end

    it 'captures the url' do
      expect(instance_variable(:@results_final)[0][:url]).to eq(instance_variable(:@data_url))
    end

    it 'captures the data fragment' do
      expect(instance_variable(:@results_final)[0][:fragment]).to eq(instance_variable(:@data_fragment))
    end

    it 'captures the raw data url' do
      expect(instance_variable(:@results_final)[0][:raw]).to eq(instance_variable(:@data_raw))
    end

  end

  describe 'trim' do

    it 'removes non-alphanumeric characters from string' do
      expect(@octokit_results.trim("/?@a")).to eq("a")
    end

  end

  describe 'regex test' do

    it 'verifies secret keys based on regex' do
      expect(@octokit_results.regex_test(@string)).to be_truthy
    end

  end

  describe 'raw file' do

    it 'compiles the raw data url from request data' do
      @octokit_results.raw_file(@object)
      expect(@octokit_results.data_raw).to eq(@raw)
    end

  end

  describe 'trim text' do

    it 'assigns data when it passes the regex' do
      @octokit_results.trim_text(@trimmed_text, @object)
      expect(@octokit_results.data_url).to eq(@url)
    end

  end

  describe 'response with false api secrets' do

    before do
      octokit_response = ResponseStub.new
      @octokit_results = OctokitResults.new
      test1 = octokit_response.invalid.pop
      @octokit_results.extract(octokit_response.invalid.pop)
    end

    it 'doesnt return a value if not inline with requirements' do
      expect(instance_variable(:@data_raw)).to eq(nil)
    end

    it 'doesnt return a value if not inline with requirements' do
      expect(instance_variable(:@data_url)).to eq(nil)
    end

    it 'doesnt return a value if not inline with requirements' do
      expect(instance_variable(:@data_fragment)).to eq(nil)
    end

  end

  def instance_variable(variable)
    @octokit_results.instance_variable_get(variable)
  end

end
