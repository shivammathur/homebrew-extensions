# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT85 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/2f6be24550fdd91ee95176e4a029fd335110f2d6.tar.gz"
  sha256 "a281490af0e0c4db3af16c8a3e3a4b2aa6bbb3a4223805432913612680e254fd"
  version "3.4.1"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    sha256 arm64_sequoia: "1eb497abd780a6e079fc38422cef994f4423f2562e374c7d331584ead71ba250"
    sha256 arm64_sonoma:  "4d323ee1d8f0a194d7a6c26b2e59b5635f387a9693cbc757f57d30e804c79ea2"
    sha256 arm64_ventura: "85e5febfb42f820499afee84c2a8843459c399e4a50e09d5fec5e86b005200f7"
    sha256 ventura:       "8fa6e58614cc73a83a61d0015475047f815d349575644562f945a180b1f96cab"
    sha256 x86_64_linux:  "be19ca3367ad25b29ebf3753c7941ad85c57d3fa434bdf9cd44d299868861565"
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
