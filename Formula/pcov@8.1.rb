# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT81 < AbstractPhp81Extension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.6.tar.gz"
  sha256 "3be3b8af91c43db70c4893dd2552c9ee2877e9cf32f59a607846c9ceb64a173b"
  head "https://github.com/krakjoe/pcov.git"
  license "PHP-3.01"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 28
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "88d37e8ae860182f1565e5b98fcd0ed4e5381d84cfddcddca6ac034999123174"
    sha256 cellar: :any_skip_relocation, big_sur:       "76cb306fa18dd805329d74efb992efd50cfa4ab360863eb6f956d6bb3bd09a07"
    sha256 cellar: :any_skip_relocation, catalina:      "ce1682dbc631bc1daf67606571d9b2f01e7c2c2c6e1043f34e5e7ba3fbd4d01e"
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
