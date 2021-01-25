# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT74 < AbstractPhp74Extension
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
    sha256 "4b4f7e1213ad8245f7ddf44f947f8b9ed19719c4f6b2a0abbac0d67b075e9982" => :big_sur
    sha256 "076719801e58f240b4103f64dac7be7583aadb3bbe9ba81d61374ca5ea62f0be" => :arm64_big_sur
    sha256 "20c91559f4c40ccd99766f7e40424827f88eeb231d868f349a1b9900e7c7b1e8" => :catalina
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
