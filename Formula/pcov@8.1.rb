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
    rebuild 24
    sha256 cellar: :any_skip_relocation, big_sur: "d058dd58ec07cd380197a0b6f26443e3e6b56585ce9ba23c14fae452fdf9b28d"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "39ff5b532710b40bb80f28595935d6fc647bfea9cc3040b7b367f8b87184cbc5"
    sha256 cellar: :any_skip_relocation, catalina: "36c066d5fe1a4edd1ff4c33e7e1df38d5ccd3dac1f953c9903002ecfa63095c5"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
