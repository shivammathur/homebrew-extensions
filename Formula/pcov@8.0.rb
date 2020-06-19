require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class PcovAT80 < AbstractPhp80Extension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.6.tar.gz"
  sha256 "3be3b8af91c43db70c4893dd2552c9ee2877e9cf32f59a607846c9ceb64a173b"
  head "https://github.com/krakjoe/pcov.git"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    cellar :any_skip_relocation
    sha256 "d3a6eec826b4b8aaf0ee3f13dad19501c11ce16fee8cd274d3ea2c6045c04aa5" => :catalina
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/pcov.so"
    write_config_file
  end
end
