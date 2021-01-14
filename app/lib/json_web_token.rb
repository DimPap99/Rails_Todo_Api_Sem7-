class JsonWebToken
  # secret to encode and decode token
  HMAC_SECRET = Rails.application.secrets.secret_key_base

  def self.encode(payload, exp = 24.hours.from_now)
    # set expiry to 24 hours from creation time

    salt_record = Salt.where(user_id: payload[:user_id]).take
    payload[:exp] = exp.to_i
    if salt_record == nil
      puts "the record doesnt exist"
      random_salt = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
      token = JWT.encode(payload, random_salt)
      salt_record = Salt.create!(user_id: payload[:user_id], salt_str: random_salt, token: token)
      puts "PRINTING THE SALT RECORD"
      p salt_record
      salt_record.token
    else
      puts "it exists"
      salt_record.salt_str = random_salt = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
      
      p payload
      puts "PRINTING THE SALT RECORD"
      p salt_record
      token = JWT.encode(payload, salt_record.salt_str)
      salt_record.token = token
      salt_record.save
      token
    end
    
    # sign token with application secret
    
  end

  def self.decode(token)
    salt_record = Salt.where(token: token).take
    p token
    p salt_record.token
    # get payload; first index in decoded Array
    body = JWT.decode(token, salt_record.salt_str)[0]
    HashWithIndifferentAccess.new body
    # rescue from all decode errors
  rescue JWT::DecodeError => e
    # raise custom error to be handled by custom handler
    raise ExceptionHandler::InvalidToken, e.message
  end
end
