module ContentIntegrator
  module Provider
    module Wordpress
      class TokenEncryptor

        def initialize(token, timestamp: Time.now.to_f)
          @raw_cipher = OpenSSL::Cipher.new("AES-256-CBC")
          @timestamp  = timestamp

          @cipher, @iv = build_cipher(token)
        end

        def call
          result = cipher.update(encryption_key)
          encrypt(result)
        end

        private

        attr_reader :cipher, :iv, :timestamp, :raw_cipher

        def encrypt(encrypted_key)
          data = encrypted_key + cipher.final
          Base64.urlsafe_encode64(data).tr("_-","/_")
        end

        def encryption_key
          iv + formatted_timestamp
        end

        def build_cipher(token)
          raw_cipher.encrypt
          raw_cipher.iv = iv
          raw_cipher.key = token

          [ raw_cipher, iv ]
        rescue ArgumentError
          raise OpenSSL::Cipher::CipherError
        end

        def formatted_timestamp
          ("%0.10f" % timestamp).tr(".","")
        end

        def iv
          @iv ||= OpenSSL::Random.random_bytes(raw_cipher.iv_len)
        end
      end
    end
  end
end
