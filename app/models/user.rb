class User
  attr_accessor :id, :email, :image

  def initialize(options = {})
    @url   = Settings.biometric_auth.url
    @id    = options['id']
    @email = options['email']
    @image = options['image']
    @image = Base64.encode64(@image.tempfile.read) rescue @image
  end

  def all
    response = Typhoeus.get("#{@url}/users")
    JSON.parse(response.body)
  end

  def save
    response = Typhoeus.post("#{@url}/users", body: { user: { email: @email, image: @image } })
    JSON.parse(response.body)
  end

  def find(id)
    response = Typhoeus.get("#{@url}/users/#{id}")
    JSON.parse(response.body)
  end

  def update(id)
    request = "#{@url}/users/#{id}"
    response = Typhoeus.put(request,
                    headers: {'Content-Type'=> "application/x-www-form-urlencoded"},
                    body: { user: { email: @email, image: @image } })
  end

  def destroy(id)
    request  = "#{@url}/users/#{id}"
    response = Typhoeus.delete(request)
  end

  def verify_user
    request = "#{@url}/rest/verify_user/"
    response = Typhoeus.post(request, body: { user: { email: @email, image: @image } })
    JSON.parse(response.body)
  end
end
