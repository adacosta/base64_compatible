module Base64Compatible
  module_function
  CHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/".split ''

  VERSION = "0.0.1"

  # === Encode Non-MIME
  # convert string to binary
  # copy groups of 8 bits to 6 bits
  # add Base64Compatible padding - 0 fill (to 6) the right side of the last bit grouping
  # add byte padding (1.8 + 1.9 compat)
  def encode64(string="")
    encoded, buffer = '', string.unpack('B*')[0]
    buffer.scan(/.{6}/).each { |nib| encoded << CHARS[nib.to_i(2)] }
    encoded << CHARS[((buffer[-(buffer.size % 6)..-1] << "00000")[/^(.{6})(.+)/,1]).to_i(2)]
    (string.send((string.respond_to?(:bytesize) ? :bytesize : :size)) % 4).times { encoded << '=' }
    encoded
  end

  # === Decode MIME and non-MIME
  # iterate string as character array
  # left pad each 6 bit representation with 0s
  # lop off trailing 0s (from encoded fill)
  # covert decoded bits to new character set
  def decode64(string="")
    decoded = ""
    string.unpack('C*').each do |char_num|
      base64_index = CHARS.index(char_num.chr)
      decoded << "%06d" % base64_index.to_s(2) if base64_index
    end
    (decoded.size % 8).times { decoded.chop! }
    decoded.gsub!(/(.{8})/) { |b| b.to_i(2).chr }
  end

  # TODO: Rework placeholders
  # def strict_encode64(bin)
  #
  # end
  #
  # def strict_decode64(str)
  #
  # end

  # TODO: Replace encode with strict versions to duplicate native lib kaboom
  def urlsafe_encode64(bin)
    encode64(bin).tr("+/", "-_")
  end

  def urlsafe_decode64(str)
    decode64(str.tr("-_", "+/"))
  end

end