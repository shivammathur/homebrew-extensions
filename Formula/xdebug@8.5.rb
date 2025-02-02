# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT85 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/45b21c242b1094e2015d044d8265f7b9b0c76919.tar.gz"
  sha256 "7715607ef8bd7822be041da94abb16888ab251e654b30ca2b623f98b219e8962"
  version "3.4.1"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sequoia: "ece4a671a6a82bb0f1cf8a7b1fc272cf0a53f2dd9de66ce3a0e2ea9b05d12992"
    sha256 arm64_sonoma:  "4671c46fcb8dc45dd8550ba0ca54d8c3593762601ddd6bac4600f06aea4d51e0"
    sha256 arm64_ventura: "0e19725d9d7a75238b408ce3b5d566839efc47cbf93d15927518434b531319a8"
    sha256 ventura:       "ac85be0071c1ebb6304c53200a8d4f80f9b282683adf0c9f934858f3cae3217a"
    sha256 x86_64_linux:  "415bf3f39f9d52decaa23631c5e19fd567519d654779d722068a83641235e756"
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
