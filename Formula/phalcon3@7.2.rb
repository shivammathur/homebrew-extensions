require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class Phalcon3AT72 < AbstractPhpExtension
  init
  desc "Full-stack PHP framework"
  homepage "https://phalcon.io/en-us"
  url "https://github.com/phalcon/cphalcon/archive/v3.4.5.tar.gz"
  sha256 "4c56420641a4a12f95e93e65a107aba8ef793817da57a4c29346c012faf66777"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "1149f13c6d62c0941f3db1ebc3540552b00104693769f519a602b8ea38c9eb63"
    sha256 cellar: :any_skip_relocation, big_sur:       "bc2f825f2b80dd1d38f699ac28c6823dfac969fc5232331034ca6ef4a17ab865"
    sha256 cellar: :any_skip_relocation, catalina:      "339cc064cfae0dd808f3c3560610894103fc86ccb925ce475796acde80d3e3bd"
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
