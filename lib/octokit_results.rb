class OctokitResults

  ALPHANUMERIC = /[^0-9a-z ]/i
  FACEBOOKEY = /^[a-f0-9_]{32}*$/

attr_reader :data_raw, :data_url

  def initialize
    @results_final = []
  end

  def extract(requested_data)
    fragment = []
    requested_data[:items].each do |object|
      fragment = object[:text_matches][0][:fragment].split("=")
      trim_text(fragment, object)
    end
  end

  def trim_text(fragment, object)
    trimmed_text = []
    fragment.each do |text|
      trimmed = trim(text)
      user_details(object) if regex_test(trimmed)
    end
  end

  def user_details(object)
    @data_url = object[:html_url]
    @data_fragment = object[:text_matches][0][:fragment]
    raw_file(object)
    user_details_save
  end

  def user_details_save
    results_raw = {:url => @data_url, :fragment => @data_fragment, :raw => @data_raw}
    @results_final << results_raw
  end

  def results_return
    @results_final
  end

  def trim(string)
    string.gsub(ALPHANUMERIC, '')
  end

  def regex_test(string)
    (FACEBOOKEY).match(string).to_s == string
  end

  def raw_file(object)
    @data_raw = "https://raw.githubusercontent.com" + "/#{object[:repository][:full_name]}" + "/#{object[:url].split('=')[1]}" + "/#{object[:name]}"
  end

end
