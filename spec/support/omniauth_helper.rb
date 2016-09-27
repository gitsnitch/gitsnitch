def set_omniauth(opts = {})
  default = {:provider => :github,
             :uuid     => "1234",
             :github => {
                            :email => "foobar@example.com",
                            :first_name => "foo",
                            :last_name => "bar"
                          }
            }

  credentials = default.merge(opts)
  provider = credentials[:provider]
  user_hash = credentials[provider]

  OmniAuth.config.test_mode = true

  OmniAuth.config.add_mock(:github, { :uid => '12345', "credentials"=> {
      :token =>"4e3e333bdf627ddae5037a75c414e354",
      :secret =>"SNZT7S70xZIhANfZzgHUEpZMPSsGEHw"
    }, :info => { :email => 'fake@example.com', :password => '65432ANFLKJA10', :nickname => "BigBerta"}})
end
