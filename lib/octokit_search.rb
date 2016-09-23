require_relative 'octokit_results'

class OctokitSearch

  def initialize(username)
    @username = username
    @octokit_results = OctokitResults.new
  end

  def search_manager
    data = code_search
    data_mine(data)
    results
  end

  def code_search
    url = "/search/code?q=facebook+user:#{@username}"
    accept_text_match = "application/vnd.github.v3.text-match+json"
    Octokit.paginate url, :accept => accept_text_match
  end

  def data_mine(data)
    data = data.pop if data.class == Array
    @octokit_results.extract(data)
  end

  def results
    @results_final = @octokit_results.results_return
  end

end
