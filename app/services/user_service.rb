class UserService

  attr_accessor :id, :email, :image, :url

  def initialize(options = {})
    @url   = Settings.biometric_auth.url
    @id    = options['id']
    @email = options['email']
    @image = options['image']
    @image = Base64.encode64(image.tempfile.read) rescue image
  end

  def all
    response = Typhoeus.get("#{url}/users")
    JSON.parse(response.body)
  end

  def save
    response = Typhoeus.post("#{url}/users", body: { user: { email: email, image: image } })
    JSON.parse(response.body)
  end

  def find(params)
    response = Typhoeus.get("#{url}/users/#{params}")
    JSON.parse(response.body)
  end

  def update(params)
    request  = "#{@url}/users/#{params}"
    response = Typhoeus.put(request,
      headers: {'Content-Type'=> "application/x-www-form-urlencoded"},
      body: { user: { email: email, image: image } })
  end

  def destroy(params)
    request  = "#{url}/users/#{params}"
    response = Typhoeus.delete(request)
  end

  def verify_user referer
    request  = "#{url}/rest/verify_user/"
    response = Typhoeus.post(request, body: { user: { email: email, image: image, referer: referer } })
    JSON.parse(response.body)
  end
end
