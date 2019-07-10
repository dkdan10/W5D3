require 'json'

class Session
  # find the cookie for this app
  # deserialize the cookie into a hash
  def initialize(req) 
    if req.cookies["_rails_lite_app"].nil?
      @rails_lite_cookie = {}
    else
      @rails_lite_cookie = JSON.parse(req.cookies["_rails_lite_app"])
    end
  end

  def [](key)
    @rails_lite_cookie[key]
  end

  def []=(key, val)
    @rails_lite_cookie[key] = val
  end

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_session(res)
    serialized = @rails_lite_cookie.to_json
    res.set_cookie("_rails_lite_app", {value: serialized})
  end
end
