require 'json'
require 'webrick'

module Phase4
  class Session
    attr_reader :req_cookie
    # find the cookie for this app
    # deserialize the cookie into a hash
    def initialize(req)
      @req_cookie = {}
      req.cookies.each do |cookie|
        @req_cookie = JSON.parse(cookie.value) if cookie.name == '_rails_lite_app'
      end
      
      @req_cookie
    end

    def [](key)
      @req_cookie[key]
    end

    def []=(key, val)
      @req_cookie[key] = val
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    def store_session(res)
      chips_ahoy = WEBrick::Cookie.new('_rails_lite_app', @req_cookie.to_json)
      res.cookies << chips_ahoy
    end
  end
end
