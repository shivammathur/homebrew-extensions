# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT71 < AbstractPhpExtension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.10.tar.gz"
  sha256 "1fd2748f2db4dbbf5f6ac1691b6bd528d23522e0fcdeeda63cbb9de2a0e8d445"
  head "https://github.com/krakjoe/pcov.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "a90bc6eb8ff11ff95e6348f8da676e74939796898a317c08e84513ad9c811fc7"
    sha256 cellar: :any_skip_relocation, big_sur:       "0af32a32c5760f10ab7bf28c6764fccdb30a5fcf07b30d3734f257073cd4ec7c"
    sha256 cellar: :any_skip_relocation, catalina:      "d40c4eb04b3cebe5d4ccf3a5bfe6de1516fa7b00c0eea419710515c596101bc8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fd244b04bbb25334a5426f497fcac48d51acc28746b1e3bc0d947b4d43105e12"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
