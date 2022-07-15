require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class Phalcon4AT74 < AbstractPhpExtension
  init
  desc "Full-stack PHP framework"
  homepage "https://phalcon.io/en-us"
  url "https://github.com/phalcon/cphalcon/archive/v4.1.3.tar.gz"
  sha256 "d6f157e033c7ebfd428190b7fe4c5db73b3cd77e8b8c291cf36d687e666a6533"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "9fa0d449c95fcfdeaea5fa25613e6d83efb2aedf9f52c69880d573cc2420a38c"
    sha256 cellar: :any_skip_relocation, big_sur:       "96d7c1ea3596f029da32e4352d49a9bf7b4f3f09f5808c1edc9a1556305bf999"
    sha256 cellar: :any_skip_relocation, catalina:      "505d95a5479e68b4535d6f57804b0635a89057cb5bd9354e4f5e50692f18a93f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1aab7533b827a5c11e3fc875b8081cd9c3009d9c01efc6bdb876313e46951b3d"
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
