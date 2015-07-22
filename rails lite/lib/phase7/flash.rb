require 'json'
require 'webrick'

module Phase7
  class Flash
    attr_accessor :slow_poke, :fast_poke
    # find the cookie for this app
    # deserialize the cookie into a hash
    def initialize(req)
      @slow_poke = {}
      @fast_poke = {}
      #basically convert the previous flash into the flash.now
      req.cookies.each do |cookie|
        @fast_poke = JSON.parse(cookie.value) if cookie.name == '_rails_lite_flash'
      end
    end

    def now
      @fast_poke
    end

    def [](key)
      @slow_poke[key.to_s] || @fast_poke[key.to_s] ||
        @slow_poke[key.to_sym] || @fast_poke[key.to_sym] 
    end

    def []=(key, val)
      @slow_poke[key] = val
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    def store_flash(res)
      chips_ahoy = WEBrick::Cookie.new('_rails_lite_flash', @slow_poke.to_json)
      res.cookies << chips_ahoy
    end
  end
end
