class OctokitClient

  def initialize(token, username)
    @token = token
    @username = username
    @client = Octokit::Client.new
    @client.access_token = token
    code_search
  end

  def code_search
    @results = @client.search_code("facebook user:#{@username}")
    html_get
  end

  def html_get
    @html = Array.new
    @results[:items].each do |result|
      @html << result.html_url
    end
  end

  def html_return
    @html
  end
end
