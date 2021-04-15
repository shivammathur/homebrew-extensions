require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class Phalcon4AT74 < AbstractPhpExtension
  init
  desc "Full-stack PHP framework"
  homepage "https://phalcon.io/en-us"
  url "https://github.com/phalcon/cphalcon/archive/v4.1.0.tar.gz"
  sha256 "3b98df3fd15560f30abbcf37b498536ad4d287699f5957b3ec37703491d3b594"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "9fa0d449c95fcfdeaea5fa25613e6d83efb2aedf9f52c69880d573cc2420a38c"
    sha256 cellar: :any_skip_relocation, big_sur:       "96d7c1ea3596f029da32e4352d49a9bf7b4f3f09f5808c1edc9a1556305bf999"
    sha256 cellar: :any_skip_relocation, catalina:      "505d95a5479e68b4535d6f57804b0635a89057cb5bd9354e4f5e50692f18a93f"
  end

  depends_on "pcre"
  depends_on "shivammathur/extensions/psr@7.4"

  def install
    Dir.chdir "build/php7/64bits"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/phalcon.so"
    write_config_file
  end
end
