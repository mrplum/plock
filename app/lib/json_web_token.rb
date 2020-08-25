class JsonWebToken
  def self.decode(token, expire = true)
    rsa_public = self.app_rsa_pub
    if rsa_public.present?
      rsa = OpenSSL::PKey::RSA.new(rsa_public)
      decoded = JWT.decode(token, rsa, expire, { algorithm: 'RS256' })[0]
    else
      nil
    end
  end

  def self.encode(user, exp = 24.hours.from_now)
    payload = self.build_payload(user, exp.to_i)
    rsa_private = self.app_rsa_private
    if rsa_private.present?
      JWT.encode(payload, rsa_private, 'RS256')
    else
      nil
    end
  end

  private

  def self.app_rsa_pub
    data = nil
    begin
      data = File.read(Rails.root.join("keys","app.rsa.pub"))
    rescue
    end
    data
  end

  def self.app_rsa_private
    data = nil
    begin
      data = OpenSSL::PKey::RSA.new(File.read(Rails.root.join("keys","app.rsa")))
    rescue
    end
    data
  end

  def self.build_user_data(user)
    {
      user_id: user.id,
      email: user.email,
      company_id: user.company_id
    }
  end

  def self.build_payload(user, exp_int)
    encrypted_user_data = Base64.encode64(build_user_data(user).to_json)
    {
      iss: "plock",
      user_data: encrypted_user_data,
      exp: exp_int
    }
  end
end
