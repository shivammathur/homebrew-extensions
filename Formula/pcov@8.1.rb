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
    rebuild 26
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "20d6b8c79303930c9e885cec23be0f822666048228ed569c6ff154df4e5801c0"
    sha256 cellar: :any_skip_relocation, big_sur:       "bcad686282f798c50716c5551c6cc82256f0c48e1bf23c3602cb9745e70a14fa"
    sha256 cellar: :any_skip_relocation, catalina:      "820847a328d980ccfa758ca1d77e3ba07b12a7366fee9c5e811a0619d5224c33"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
