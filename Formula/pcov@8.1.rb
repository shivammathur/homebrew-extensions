# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT81 < AbstractPhpExtension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.10.tar.gz"
  sha256 "1fd2748f2db4dbbf5f6ac1691b6bd528d23522e0fcdeeda63cbb9de2a0e8d445"
  head "https://github.com/krakjoe/pcov.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "87f343b0ea498be44809295921121d46fb8b66a9fe1828cdd4b0db3142bdf3bc"
    sha256 cellar: :any_skip_relocation, big_sur:       "70254ce643e523bf8426865ed1041364255500bff0c9799fd18467ed0e40ecbc"
    sha256 cellar: :any_skip_relocation, catalina:      "88d82b347bb89d1759eb0c5da813055bf696a95a3834b4b3f8be404a6ae2a63c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2b8a50b9ccb1a1f6c21b947f1bcb8093dd37ccb66f2529555c96be9489a2238e"
  end

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
