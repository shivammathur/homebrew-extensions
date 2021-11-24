# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT73 < AbstractPhpExtension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.10.tar.gz"
  sha256 "1fd2748f2db4dbbf5f6ac1691b6bd528d23522e0fcdeeda63cbb9de2a0e8d445"
  head "https://github.com/krakjoe/pcov.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "7a33af06b9d9a723eb9b1029666a85fa2342e3c62ad2f2c2aad2aa821dbe8cdf"
    sha256 cellar: :any_skip_relocation, big_sur:       "86b08fcb5414e60f3d20b0361a382a76e82cbfeb5da6e3220aebee6516871b43"
    sha256 cellar: :any_skip_relocation, catalina:      "da955eecff2d8505e239f2581fe606b6bd3c049eda9fa5bc8dbbeb9e5820bd69"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c6e85ccb22953eb6488f1ca71752e468d8286d10e8318aa7ecf1ce44bffea1ac"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
