module ContentIntegrator
  module Utils
    def self.symbolize_keys(hash)
      hash.inject({}) do |memo, (key, value)|
        memo[key.to_sym] = value
        memo
      end
    end

    def self.open_image_from_url(image_url)
      image_file = open(image_url)
      return image_file unless image_file.is_a?(StringIO)

      image_from_temp_file(image_url, image_file)
    end

    def self.parse_expiration_date(expires_in)
      expires = expires_in.to_i
      if expires > 0
        return Time.now.utc + expires
      end
    end

    class << self
      private

      def image_from_temp_file(image_url, image_file)
        file_name = File.basename(image_url)
        temp_file = open_as_tempfile(file_name, image_file)

        open(temp_file.path)
      end

      def open_as_tempfile(file_name, image_file)
        temp_file = Tempfile.new(file_name_digested(file_name))
        temp_file.binmode
        temp_file.write(image_file.read)
        temp_file.close

        temp_file
      end

      # Prevents file name error too long
      def file_name_digested(file_name)
        Digest::MD5.hexdigest(file_name)
      end
    end
  end
end
