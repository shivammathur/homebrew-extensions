require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class Phalcon3AT71 < AbstractPhpExtension
  init
  desc "Full-stack PHP framework"
  homepage "https://phalcon.io/en-us"
  url "https://github.com/phalcon/cphalcon/archive/v3.4.5.tar.gz"
  sha256 "4c56420641a4a12f95e93e65a107aba8ef793817da57a4c29346c012faf66777"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "0598a203279e0f07695d3e1c7648bf16e797ded88aaad1d49104483d4596c63a"
    sha256 cellar: :any_skip_relocation, big_sur:       "7b45f98d2144ef08f4649fc8ae181787c1bbfc7a7cb0519f07f4a3e6d8401d6b"
    sha256 cellar: :any_skip_relocation, catalina:      "95ba6a141cee048cad040562a79b2b41b08a393f2d525884639dbf9c4bd03c60"
  end

  depends_on "pcre"
  depends_on "shivammathur/extensions/psr@7.1"

  def install
    Dir.chdir "build/php7/64bits"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/phalcon.so"
    write_config_file
  end
end
