# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT85 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/4d7890252a1d544b94609440962030d6483b34ef.tar.gz"
  sha256 "e905bc9110b95d390b11e4d09dca39464e10d7c950e9d63133b65553ce608912"
  version "3.4.1"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 13
    sha256 arm64_sequoia: "ca2170ae3ea76e59313d360c6c33ced28acf902c77e7c8495ff25bfd5268e098"
    sha256 arm64_sonoma:  "cb263abaf88eb7b803172b5457fcffc1cd4b5559b4e675310ec6547ce1a5082e"
    sha256 arm64_ventura: "ddcfa29f50d50ee8394c3307f02264088e35e34202628561edba8ec2e9cd8af8"
    sha256 ventura:       "8bafba0edabbf1f8ab5431ac96efac69e71aee3cd02e4564410d72d4c9f5cf65"
    sha256 arm64_linux:   "6ebf48af7f1e58c85e2115a509841fd60fa5fa920992eb486edfa1b77517d2bd"
    sha256 x86_64_linux:  "510953a5083897043267dd8f0a3252e5c4723b348d28cd3821c73002ce2296a5"
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
