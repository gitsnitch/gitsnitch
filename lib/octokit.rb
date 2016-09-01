class OctokitClient

  def initialize(token, username)
    @token = token
    @username = username
    @client = Octokit::Client.new
    @client.access_token = token
    @info = Hash.new
    code_search
  end

  def code_search
    url = "/search/code?q=facebook+user:CONDOTH1"
    accept_text_match = "application/vnd.github.v3.text-match+json"
    @test1 = Octokit.paginate url, :accept => accept_text_match
    test2 = @test1[:items][1].text_matches
    info_get
  end

  def info_get
    @fragment = Array.new
    @test1[:items].each do |testing|
        test_hash = {:url => testing.text_matches[0].object_url, :fragment => testing.text_matches[0].fragment}
        @fragment << test_hash
    end
  end


  def fragment_return
    @fragment
  end

end
