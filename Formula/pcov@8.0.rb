# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT80 < AbstractPhp80Extension
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
    rebuild 2
    sha256 "169206337e23d9d3c47f84b69fe0f7422b6beeda76679fbd31897f4fee568dc3" => :big_sur
    sha256 "6bbb19c068527c4f04b476d3cfc6b72d2447c6a4eef876fa0c299c58e19d9122" => :arm64_big_sur
    sha256 "54a5ec7c51c96354fe13a3b92b4aead1282c9d2c637f293651b762c62ad8aa54" => :catalina
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
