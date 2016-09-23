# require './spec/rails_helper'
#
# describe 'DataRefine' do
#
#   before do
#     octokit_response = ResponseStub.new
#     @octokit_results = OctokitResults.new
#     @object = octokit_response.valid.pop[:items][0]
#     @string = @octokit_results.trim(octokit_response.secret_valid)
#     @trimmed_text = octokit_response.trimmed_text
#     @url = octokit_response.url
#     @raw = octokit_response.raw
#     @fragment = octokit_response.fragment
#   end
#
#   describe 'trim' do
#
#     it 'removes non-alphanumeric characters from string' do
#       expect(@octokit_results.trim("/?@a")).to eq("a")
#     end
#
#   end
#
#   describe 'regex test' do
#
#     it 'verifies secret keys based on regex' do
#       expect(@octokit_results.regex_test(@string)).to be_truthy
#     end
#
#   end
#
#   describe 'raw file' do
#
#     it 'compiles the raw data url from request data' do
#       @octokit_results.raw_file(@object)
#       expect(@octokit_results.data_raw).to eq(@raw)
#     end
#
#   end
#
#   describe 'trim text' do
#
#     it 'assigns data when it passes the regex' do
#       @octokit_results.trim_text(@trimmed_text, @object)
#       expect(@octokit_results.data_url).to eq(@url)
#     end
#
#   end
# end
