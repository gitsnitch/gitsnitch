require './spec/rails_helper'

describe 'DataRefine' do

  before do
    octokit_response = ResponseStub.new
    @data_refine = DataRefine.new
    @object = octokit_response.valid.pop[:items][0]
    @string = @data_refine.trim(octokit_response.secret_valid)
    @url = octokit_response.url
    @raw = octokit_response.raw
    @fragment = octokit_response.fragment
  end

  describe 'trim' do

    it 'removes non-alphanumeric characters from string' do
      expect(@data_refine.trim("/?@a")).to eq("a")
    end

  end

  describe 'regex test' do

    it 'verifies secret keys based on regex' do
      expect(@data_refine.regex_test(@string)).to be_truthy
    end

  end

  describe 'raw file' do

    it 'compiles the raw data url from request data' do
      @data_refine.raw_file(@object)
      expect(@data_refine.data_raw).to eq(@raw)
    end

  end

  describe 'data assign' do

    it 'assigns data when it passes the regex' do
      @data_refine.data_assign(@object, @string)
      expect(@data_refine.data_url).to eq(@url)
    end

  end
end
