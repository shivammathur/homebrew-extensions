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
    rebuild 29
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "c9beba9bea4f1b55240bca2e0f4976bfa69ec0f283fb25bae13ccdfe9f8b14ed"
    sha256 cellar: :any_skip_relocation, big_sur:       "0a06114c1f7ab321bafae0b5d07e2d22c88441034e3457928e4eda72d5d5e2c0"
    sha256 cellar: :any_skip_relocation, catalina:      "001613c2d5850444fef85fe21d67f954a9ebc4d5a69ee6b9a6bdec21add2adf3"
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
