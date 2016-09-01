class OctokitClient

  def initialize(token, username)
    @token = token
    @username = username
    @client = Octokit::Client.new
    @client.access_token = token
    @html = Array.new
    @results = Array.new
    @search_phrases = [
     "app_id user:#{@username}","secret_base user:#{@username}",
     "client_secret user:#{@username}","client_id user:#{@username}",
     "org_id user:#{@username}","org_secret user:#{@username}","key_id user:#{@username}",
     "access_key ser:#{@username}","session_token user:#{@username}","secret_access_key user:#{@username}",
     "security_token user:#{@username}","user_id user:#{@username}","profile_id user:#{@username}"
    ]
    code_search
  end

  def code_search
    @search_phrases.each do |phrase|
      @results << @client.search_code(phrase)
      html_get
    end

  end


  def html_get
    @results.each do |result|
      result[:items].each do |l|
        @html << l.html_url
    end
    end
    "==============#{@html}==========="
  end

  def html_return
    @html
  end
end
