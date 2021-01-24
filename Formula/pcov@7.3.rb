# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT73 < AbstractPhp73Extension
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
    sha256 "d9cf730beee82e15a3ba6cddcdbf835d6f9b1c5d5a3c5d55dc67a043493dc6a8" => :big_sur
    sha256 "4d6f69f73ccc7e06f96f5e10ce8ee61dd530bdda2772389271ba7eb34eb511fd" => :arm64_big_sur
    sha256 "fc1de16dad0f8573445f54fdd15ba19414b7e75fe130779d049ac37417e833b8" => :catalina
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/pcov.so"
    write_config_file
  end
end
