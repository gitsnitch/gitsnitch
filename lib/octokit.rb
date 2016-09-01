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
    # test2 = @test1[:items][1].text_matches
    # test3 = test2[0].fragment
    # test4 = test3.split("=")
    # test5 = test4[2].gsub(/[^0-9a-z ]/i, '')
    # p "==================#{/^[a-f0-9_]{32}*$/.match(test5)}==================="
    info_get
  end

  def info_get
    @fragment = Array.new
    @test1[:items].each do |testing|
      data = check_testing(testing.text_matches[0].fragment)
      p "============1======#{data}==================="
      if data
        test_hash = {:url => testing.html_url, :fragment => data}
        test_hash[:url].sub! "github.com", "raw.githubusercontent.com"
        test_hash[:url].sub! "blob/", ""
        @fragment << test_hash
      end
    end
  end

  def check_testing(string)
    # p "============1======#{array}==================="
    test1 = string.split("=")
    test1.each do |string1|
      # p "============1======#{string}==================="
      test5 = string1.gsub(/[^0-9a-z ]/i, '')
      # p "============2======#{test5}==================="
      # p "============2======#{/^[a-f0-9_]{32}*$/.match(test5).to_s == test5}==================="
      if (/^[a-f0-9_]{32}*$/).match(test5).to_s == test5
        return string
      end
    end
  end
  # /^[a-f0-9_]{32}*$/.match


  def fragment_return
    @fragment
  end

end
