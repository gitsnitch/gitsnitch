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
    info_get
  end

  def info_get
    @fragment = Array.new
    @test1[:items].each do |testing|
      check_testing(testing.text_matches[0].fragment)
      if @data
        test_hash = {:url => testing.html_url, :fragment => @data}
        test_hash[:url].sub! "github.com", "raw.githubusercontent.com"
        test_hash[:url].sub! "blob/", ""
        @fragment << test_hash
      end
    end
  end

  def check_testing(string)
    @data = nil
    test1 = string.split("=")
    test1.each do |string1|
      test5 = string1.gsub(/[^0-9a-z ]/i, '')
      if (/^[a-f0-9_]{32}*$/).match(test5).to_s == test5
         @data = string
      end
    end
  end


  def fragment_return
    @fragment
  end

end
