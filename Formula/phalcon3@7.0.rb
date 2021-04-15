require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class Phalcon3AT70 < AbstractPhpExtension
  init
  desc "Full-stack PHP framework"
  homepage "https://phalcon.io/en-us"
  url "https://github.com/phalcon/cphalcon/archive/v3.4.5.tar.gz"
  sha256 "4c56420641a4a12f95e93e65a107aba8ef793817da57a4c29346c012faf66777"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "a1f2fd4253af4d70cf34f3a4de8538df6de6a0257dd2bb73144ab7e91ea4619e"
    sha256 cellar: :any_skip_relocation, big_sur:       "ab5c8dc72a33bd6d701eb2808a94779284ca5315d2ad4b709b7af9305fb7fa31"
    sha256 cellar: :any_skip_relocation, catalina:      "0cf41782d5d48537bbe9335409f9b9e8771624591aa38c32634d1297fc171269"
  end

  depends_on "pcre"
  depends_on "shivammathur/extensions/psr@7.0"

  def install
    Dir.chdir "build/php7/64bits"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/phalcon.so"
    write_config_file
  end
end
