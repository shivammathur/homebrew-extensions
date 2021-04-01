# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT81 < AbstractPhp81Extension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.8.tar.gz"
  sha256 "f67a1c1aabe798e5bb85d0ea8c7b1d27b226b066d12460da8d78b48bfc6f455e"
  head "https://github.com/krakjoe/pcov.git"
  license "PHP-3.01"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "12c73f45625f2b6dbebc35b01ad116932d705c06a5e4c106d9fdd8837d7c3ef4"
    sha256 cellar: :any_skip_relocation, big_sur:       "15602747509a97a9d9b99643a797b1a5c172d1eae7ab3c392a5cde55dc917d7d"
    sha256 cellar: :any_skip_relocation, catalina:      "1bf7ba1a154318856d1c132a8e569bfc3fb9fc097fd03582a8080d7134de8a34"
  end

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
