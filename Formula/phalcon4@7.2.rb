require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class Phalcon4AT72 < AbstractPhp72Extension
  init
  desc "Full-stack PHP framework"
  homepage "https://phalcon.io/en-us"
  url "https://github.com/phalcon/cphalcon/archive/v4.1.0.tar.gz"
  sha256 "3b98df3fd15560f30abbcf37b498536ad4d287699f5957b3ec37703491d3b594"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "4073e8527dd4e0b2694f2a725d070165689d5fc80dcb742d261050f03dfa28ab"
    sha256 cellar: :any_skip_relocation, big_sur:       "da148fafab8d031e0491a56ab23c67d2eb1c34ec837a1e4fce7d124b7c0ffb9c"
    sha256 cellar: :any_skip_relocation, catalina:      "7dd7cb427fef5bc2a87df0439babab73cb73071d991ad44344f5278e254ee999"
  end

  depends_on "pcre"
  depends_on "shivammathur/extensions/psr@7.2"

  def install
    Dir.chdir "build/php7/64bits"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/phalcon.so"
    write_config_file
  end
end
