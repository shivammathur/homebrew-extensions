require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class Phalcon4AT73 < AbstractPhpExtension
  init
  desc "Full-stack PHP framework"
  homepage "https://phalcon.io/en-us"
  url "https://github.com/phalcon/cphalcon/archive/v4.1.3.tar.gz"
  sha256 "d6f157e033c7ebfd428190b7fe4c5db73b3cd77e8b8c291cf36d687e666a6533"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "4599c79039e8c714155a15f97666f3887893576e2844137d704cd9ab8cc3f425"
    sha256 cellar: :any_skip_relocation, big_sur:       "51f80189bde2b7f4563c2289ded069fb06b1aeba57fc99d2a134a908b39927a1"
    sha256 cellar: :any_skip_relocation, catalina:      "9ea42e8e5c1f9dc94a9d205cd3bad961d390c8930f7434f09268317fa7dda84f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bdc4736fef8643bfc7fe43c1ada895da5c4b2cf60c1b68533daeca6603d4185c"
  end

  depends_on "pcre"
  depends_on "shivammathur/extensions/psr@7.3"

  def install
    Dir.chdir "build/php7/64bits"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/phalcon.so"
    write_config_file
  end
end
