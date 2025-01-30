# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT80 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.4.1.tar.gz"
  sha256 "9cf77233d9a27517b289c66e49883bdb4088ae39056cd0b67c3a1d8596b21080"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sequoia: "a36bdadafd522089fe8a474b889e9c4ea0c1cd12a942af9d5da5985674504c59"
    sha256 arm64_sonoma:  "b7c3f2dd6119a9ca4a9fa60ae3b8e59cb472ee6819be5fdca27ec063934a90db"
    sha256 arm64_ventura: "8f2f6d019ae01027e869c6f2a28d30b40b53a02bdd175be737d48034736c4205"
    sha256 ventura:       "47cabf7be5d33728be563b12b81b112d6cac830e4eb55511babcc8964281dad8"
    sha256 x86_64_linux:  "c85846d14ff45ef5828aca4520c7662726a4dadd99a5cc9ea75d3e1058e0da9e"
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
