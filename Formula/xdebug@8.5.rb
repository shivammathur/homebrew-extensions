# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT85 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/8ee4631e3b82a5382f0d1c76cd2abdaa2f8c26bd.tar.gz"
  sha256 "a935c9a0dc66e3dffb388e249c57bac3ee94e4ebb7c1e63a77a39d6481155024"
  version "3.4.1"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 arm64_sequoia: "24970d5eaae32c8031a71fa5d395863e652716aff79e5e098e8583d1e38a7325"
    sha256 arm64_sonoma:  "ac8421082ebaf4558f9cdecdde6575291f5d7d279e15b49a8f3fce20f1393ae2"
    sha256 arm64_ventura: "af409db552f221d221c38dafd19ad0ac947b9a5c4b48e5acc0d390d4e8259e76"
    sha256 ventura:       "2daca7449af08aca2026bb236a04888085cf2ee8c398c29ff835d3dadc310848"
    sha256 x86_64_linux:  "ebbc63ab7fbbdae99607932082a6f941f671df7c113b3e0ea44efd76b86ce735"
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
