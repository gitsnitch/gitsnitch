class OctokitClient

  def initialize(token, username)
    @username = username
    @client = Octokit::Client.new
    @client.access_token = token
    @results_final = Array.new
    code_search
  end

  def code_search
    url = "/search/code?q=facebook+user:#{@username}"
    accept_text_match = "application/vnd.github.v3.text-match+json"
    @requested_data = Octokit.paginate url, :accept => accept_text_match
    data_extract
  end

  def data_extract
    @requested_data[:items].each do |object|
      data_check(object)
      if data_valid
        results_capture
      end
    end
  end

  def results_capture
    results_raw = {:url => @data_url, :fragment => @data_fragment, :raw => @data_raw}
    @results_final << results_raw
  end

  def data_check(object)
    data_reset
    split_text = object.text_matches[0].fragment.split("=")
    split_text.each do |string|
      refine_split(object, string)
    end
  end

  def refine_split(object, string)
    fragment = string.gsub(/[^0-9a-z ]/i, '')
    data_assign(object, fragment)
  end

  def data_assign(object, fragment)
    if regex_test(fragment)
       @data_url = object.html_url
       @data_fragment = object.text_matches[0].fragment
       raw_file(object)
    end
  end

  def regex_test(string)
    (/^[a-f0-9_]{32}*$/).match(string).to_s == string
  end

  def data_reset
    @data_url = nil
    @data_fragment = nil
    @data_raw = nil
  end

  def data_valid
    @data_url && @data_fragment
  end

  def raw_file(object)
    @data_raw = "https://raw.githubusercontent.com" + "/#{@username}" + "/#{object[:repository].name}" + "/#{object[:url].split('=')[1]}" + "/#{object[:name]}"
  end

  def results_return
    @results_final
  end

end
