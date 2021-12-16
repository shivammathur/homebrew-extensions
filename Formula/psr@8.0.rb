require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class PsrAT80 < AbstractPhpExtension
  init
  desc "PHP extension providing the accepted PSR interfaces "
  homepage "https://github.com/jbboehr/php-psr"
  url "https://pecl.php.net/get/psr-1.2.0.tgz"
  sha256 "9c3d2a0d9770916d86e2bc18dfe6513ad9b2bfe00f0d03c1531ef403bee38ebe"
  head "https://github.com/jbboehr/php-psr.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "2fcba9ffe08c3f4bbc26e175c6ec3ff226a3da02e476db5566501bbde5163875"
    sha256 cellar: :any_skip_relocation, big_sur:       "65fa799732159ee765720d3de6d6868a7164f23ab765dbc4bd9d7bb3fe7ae612"
    sha256 cellar: :any_skip_relocation, catalina:      "06be1d756c30838e24e064ff16677a501a3ca526d18c0ac645fe3fc024b1f907"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f548e19ba5b850f9a5523d93bf6dee584ff9694c8fad755bbb393a0ebf335e48"
  end

  depends_on "pcre"

  def install
    Dir.chdir "psr-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-psr"
    system "make"
    prefix.install "modules/psr.so"
    write_config_file
  end
end
