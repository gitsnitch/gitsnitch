class ResponseStub

  attr_reader :secret_valid, :secret_invalid, :url, :raw, :fragment, :trimmed_text

  def initialize
    @trimmed_text = ["4e3e333bdf627ddae5037a75c414e354"]
    @secret_valid = "4e3e333bdf627ddae5037a75c414e354"
    @secret_invalid= "4e3e333bdf627ddae5037a75c414"
    @url = "https://github.com/CONDOTH1/gitsnitch_test/blob/af12ec7492c394da29f85d3c03a53cc79a74251b//testfile.md"
    @raw = "https://raw.githubusercontent.com/CONDOTH1/gitsnitch_test/af12ec7492c394da29f85d3c03a53cc79a74251b/testfile.md"
    @fragment = "fake FACEBOOK_APP_ID=947996911009968, fake FACEBOOK_APP_SECRET=4e3e333bdf627ddae5037a75c414e354"
  end

  def valid
    [{:items => [{:name => "testfile.md", :html_url =>      "https://github.com/CONDOTH1/gitsnitch_test/blob/af12ec7492c394da29f85d3c03a53cc79a74251b//testfile.md", :url =>  "https://api.github.com/repositories/67030001/contents//testfile.md?ref=af12ec7492c394da29f85d3c03a53cc79a74251b", :repository => {   :full_name=>"CONDOTH1/gitsnitch_test"}, :text_matches => [{:fragment=> "fake FACEBOOK_APP_ID=947996911009968, fake FACEBOOK_APP_SECRET=#{@secret_valid}"}]}]}]
  end

  def invalid
    [{:items => [{:name => "testfile.md", :html_url =>     "https://github.com/CONDOTH1/gitsnitch_test/blob/af12ec7492c394da29f85d3c03a53cc79a74251b//testfile.md", :url => "https://api.github.com/repositories/67030001/contents//testfile.md?ref=af12ec7492c394da29f85d3c03a53cc79a74251b", :repository => { :full_name=>"ahcrap"}, :text_matches => [{:fragment=> "fake FACEBOOK_APP_ID=947996911009968, fake FACEBOOK_APP_SECRET=#{@secret_invalid}"}]}]}]
  end

end
