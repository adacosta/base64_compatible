require File.dirname(__FILE__) + '/base'
require 'strings'
require 'base64' # compare with

class TC_Base64Compatible < Test::Unit::TestCase
  include Strings

  def test_encode_and_decode
    assert_equal LOGIN_STRING, Base64Compatible.decode64(Base64Compatible.encode64(LOGIN_STRING))
    assert_equal STRING, Base64Compatible.decode64(Base64Compatible.encode64(STRING))
    assert_equal PARAGRAPH, Base64Compatible.decode64(Base64Compatible.encode64(PARAGRAPH))
  end

  def test_encode_is_non_mime
    # \n is a MIME marker
    assert (Base64Compatible.encode64(PARAGRAPH)[/\n/].nil?)
    # Base64 encodes mime...verify our output doesn't match
    assert_not_equal Base64.encode64(PARAGRAPH), Base64Compatible.encode64(PARAGRAPH)
  end

  # NOTE: Depending on byte alignment, codings can be equal.
  #       One example is the included STRING test, where PARAGRAPH wouldn't
  #       show the same result.
  #       assert_equal PARAGRAPH, Base64.decode64(Base64Compatible.encode64(PARAGRAPH)) #=> true
  def test_base64_std_lib_fails_decoding_non_mime
    # Base64 can't decode non-MIME encoded base64
    assert_not_equal STRING, Base64::decode64(Base64Compatible.encode64(STRING))
  end

  def test_can_decode_base64_std_lib
    # decode works on MIME encoded base64
    assert_equal LOGIN_STRING, Base64Compatible.decode64(Base64.encode64(LOGIN_STRING))
    assert_equal STRING, Base64Compatible.decode64(Base64.encode64(STRING))
    assert_equal PARAGRAPH, Base64Compatible.decode64(Base64.encode64(PARAGRAPH))
  end

end