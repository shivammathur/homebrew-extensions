# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT85 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/b85b31fe9e14fddd869431257eab080768c5a48b.tar.gz"
  sha256 "65135f4f0cfaf20b823e4c3c8834f10eae1d112e76df928926205c8eb1666842"
  version "3.4.1"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 9
    sha256 arm64_sequoia: "bcd81db24741eb1b45d19b8193e692524cee97dd325ac85da9fdf62f56b5b1ad"
    sha256 arm64_sonoma:  "339b7b8a204e2163a2fe54a582f1bd0e62f9504fe349bc514d9ec404eefcbe1c"
    sha256 arm64_ventura: "445cea0a4d4566314d50d61efea2580994d4ec7312bc6e22add38b2734232e8d"
    sha256 ventura:       "1869d44d4e400220da8596ac4e1afa8214d395a8fe472b14c32cde6b7061888d"
    sha256 arm64_linux:   "be3b193afdfd8b352d7108b8b60e233f36a4b4a0984b5e079ddb04535b8f4e1e"
    sha256 x86_64_linux:  "0fbbf7b3720fa942b9664e675fbc167d733b3612acd360c957fedb646fcbe7d1"
  end

  uses_from_macos "zlib"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
