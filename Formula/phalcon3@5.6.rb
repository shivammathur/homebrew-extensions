require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class Phalcon3AT56 < AbstractPhp56Extension
  init
  desc "Full-stack PHP framework"
  homepage "https://phalcon.io/en-us"
  url "https://github.com/phalcon/cphalcon/archive/v3.4.5.tar.gz"
  sha256 "4c56420641a4a12f95e93e65a107aba8ef793817da57a4c29346c012faf66777"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "2994a241d54910c57632c23c4f9692399db9e9856205743ec50d22b044231f28"
    sha256 cellar: :any_skip_relocation, big_sur:       "7baabf661cd9d619a32a4a3ffc6935220d54fcba56d6cb289589440a2816c1cc"
    sha256 cellar: :any_skip_relocation, catalina:      "27609b942a6e61bac3369616ddf18375623b60eb4ed81403385ca2cc91671499"
  end

  depends_on "pcre"
  depends_on "shivammathur/extensions/psr@5.6"

  def install
    Dir.chdir "build/php5/64bits"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/phalcon.so"
    write_config_file
  end
end
