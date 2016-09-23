class OctokitResults

  ALPHANUMERIC = /[^0-9a-z ]/i
  FACEBOOKEY = /^[a-f0-9_]{32}*$/

  def initialize
    @results_final = []
  end

  def extract(requested_data)
    # split_text = requested_data[:items][0][:text_matches][0][:fragment].split("=")

    requested_data[:items].each do |object|
      fragment = object[:text_matches][0][:fragment].split("=")

      p "fragment=============#{fragment}"

      fragment = object_split(object)
      user_details_create(object, fragment)
      user_details_save if results_valid
    end
  end

  def user_details_save
    results_raw = {:url => @data_url, :fragment => @data_fragment, :raw => @data_raw}
    @results_final << results_raw
  end

  def results_return
    @results_final
  end

  def object_split(object)
    split_text = object[:text_matches][0][:fragment].split("=")
    split_text.each do |string|
      apikey = trim(string)
      return apikey if regex_test(apikey)
    end
  end

  def trim(string)
    string.gsub(ALPHANUMERIC, '')
  end

  def user_details_create(object, fragment)
    if regex_test(fragment)
       @data_url = object[:html_url]
       @data_fragment = object[:text_matches][0][:fragment]
       raw_file(object)
    end
  end

  def regex_test(string)
    (FACEBOOKEY).match(string).to_s == string
  end

  def raw_file(object)
    @data_raw = "https://raw.githubusercontent.com" + "/#{object[:repository][:full_name]}" + "/#{object[:url].split('=')[1]}" + "/#{object[:name]}"
  end

  def results_valid
    @data_url && @data_fragment
  end

end
