# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT72 < AbstractPhp72Extension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.6.tar.gz"
  sha256 "3be3b8af91c43db70c4893dd2552c9ee2877e9cf32f59a607846c9ceb64a173b"
  head "https://github.com/krakjoe/pcov.git"
  license "PHP-3.01"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    cellar :any_skip_relocation
    rebuild 1
    sha256 "b9846c66ff68e7fb5568bbcf71e6436fb6bda6a0e1ffa75a7bed79b88b1d6e8b" => :big_sur
    sha256 "aca2790ddd4a1ec745d97a9d4c5664d02211b9c85a2ad6aac1d007e9d6a281ba" => :arm64_big_sur
    sha256 "309d722ed33a93739434fd9949fd004078b051f26e3c75fe39e1d7250a9f7628" => :catalina
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/pcov.so"
    write_config_file
  end
end
