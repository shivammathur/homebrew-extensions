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
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "7a51b5169f9775efdab9feb0eb05de4a6359d001390210457b635705c7f5ea1a"
    sha256 cellar: :any_skip_relocation, big_sur:       "9df7f695617e2da12d6280383452169f5cfc8983256fbb67a724b7476ae56e5d"
    sha256 cellar: :any_skip_relocation, catalina:      "8743c0d4cc2c675bf8493a20ec93dfc22f45dfe969df31651b59f6ee07774ab8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5400228e9ca5c4834d6d0dad5d588b8beaedcffcbd081f820c5045d468f0567d"
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
