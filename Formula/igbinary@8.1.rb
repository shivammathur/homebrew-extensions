# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT81 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.7.tar.gz"
  sha256 "21863908348f90a8a895c8e92e0ec83c9cf9faffcfd70118b06fe2dca30eaa96"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "8ccca3e8c444a7f9fc3c8989a7ef643e0c30d0e173d542f4385f11aff1ce36ce"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "d1b71245663710ede78687f7c768c670d623089ed0d5f5f4e4d2a908cba6a13c"
    sha256 cellar: :any_skip_relocation, monterey:       "0ce4a4cb5aeb87dd48722c648da3d40a6667771194629696abea1dae6ac197c5"
    sha256 cellar: :any_skip_relocation, big_sur:        "6c6fa092a95dcfc31489568e383534212392e31af910ca51f801270def45949b"
    sha256 cellar: :any_skip_relocation, catalina:       "ac02b4aa8f6b1da02f3cb12fbb1b67d06d410f5d7ee0657b5e69d8342cd0b066"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "db2d1339d0a56f62f8677069906aec86ded1cf209cb1fc0f572235d6fe1b37f7"
  end

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
