# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT85 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/141ce2f6b542abde318f373cc927edf8fdb68cb5.tar.gz"
  sha256 "7b91ab7bc5c2568ed38f29514efcbc57415c0a8f6389c609dacb0e5589b9df1c"
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
