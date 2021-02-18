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
    rebuild 27
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "a3b85531ef15903f3923667ebe149c8a660b2f070e6cc4e1a2b10f822838f022"
    sha256 cellar: :any_skip_relocation, big_sur:       "ccb5a67b9b81b52dd833e32b56feb8bb633a595622763e2c546646c8cd5a3df7"
    sha256 cellar: :any_skip_relocation, catalina:      "1aaef8843694b034390324e8f196efbec44a66f36ba1962c94b42a2fb76fb6f4"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
