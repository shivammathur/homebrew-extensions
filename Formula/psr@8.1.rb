require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class PsrAT81 < AbstractPhpExtension
  init
  desc "PHP extension providing the accepted PSR interfaces "
  homepage "https://github.com/jbboehr/php-psr"
  url "https://pecl.php.net/get/psr-1.2.0.tgz"
  sha256 "9c3d2a0d9770916d86e2bc18dfe6513ad9b2bfe00f0d03c1531ef403bee38ebe"
  head "https://github.com/jbboehr/php-psr.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "10c9ffb7c26322e15a31a5c76738373700c1dffa7dcf50b58d8d88039fc58b03"
    sha256 cellar: :any_skip_relocation, big_sur:       "1ece510202d7e20636ecb484b1f53288de79ddfec70722a286356897fb65e710"
    sha256 cellar: :any_skip_relocation, catalina:      "bbbd13f6980e4e66c58e53796ad52aade74d7c72c4ccc7a2b04ba4334ffb06ee"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "83f6f70608661ad559fb998fdb79434c56a532816d6e198882ee35917df4d56e"
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
