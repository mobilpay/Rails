require "openssl"
require "base64"

class OpenSSLWrapper
  def self.unseal(mykey,env_key,data)
    privkey = OpenSSL::PKey::RSA.new(mykey)
    key = privkey.private_decrypt(Base64.decode64(env_key))
    cipher = OpenSSL::Cipher.new('rc4')
    cipher.decrypt
    cipher.key = key

    cipher.update(Base64.decode64(data)) + cipher.final
  end

  def self.seal(cert,text)
   
    cipher = OpenSSL::Cipher.new('rc4')
    env_key = cipher.random_key
    cipher.encrypt
    cipher.key = env_key
    cipher.iv = iv = cipher.random_iv
    data = cipher.update(text) + cipher.final

    cert = OpenSSL::X509::Certificate.new(cert)
    pubkey = cert.public_key
    env_key = pubkey.public_encrypt(env_key);
    {:env_key=>Base64.encode64(env_key),:data=>Base64.encode64(data)}
  end
end
