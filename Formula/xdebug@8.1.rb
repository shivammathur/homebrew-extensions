# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT81 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.4.1.tar.gz"
  sha256 "9cf77233d9a27517b289c66e49883bdb4088ae39056cd0b67c3a1d8596b21080"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sequoia: "5a386978985ffc72f2ee5e3c78de200ac195296cb5ce2569bce0f592f80590fc"
    sha256 arm64_sonoma:  "f745b1676c59cf7ab40c9e8587aa47934a567a1ee9427f2f25b42bd2a98d96a0"
    sha256 arm64_ventura: "6d5c9db85e7a937424814c0bc06c8c95f4a8c51f5aa399aed899b938dace238c"
    sha256 ventura:       "f02c1d209a456a6f9cfd9c961ec97f8e3e45a2b68a804f1f7d92e6457d6d7254"
    sha256 x86_64_linux:  "8887791b1e44ca35603bf0f6657ff5fb5401fa66717f9b8a8b80a91d42c1b592"
  end

  uses_from_macos "zlib"

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
