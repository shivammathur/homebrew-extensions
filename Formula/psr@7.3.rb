require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class PsrAT73 < AbstractPhpExtension
  init
  desc "PHP extension providing the accepted PSR interfaces "
  homepage "https://github.com/jbboehr/php-psr"
  url "https://pecl.php.net/get/psr-1.2.0.tgz"
  sha256 "9c3d2a0d9770916d86e2bc18dfe6513ad9b2bfe00f0d03c1531ef403bee38ebe"
  head "https://github.com/jbboehr/php-psr.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "a76535e65564a7a25ee69729654d9436b13339e0be24ba660894a2aa9282d91f"
    sha256 cellar: :any_skip_relocation, big_sur:       "19a50b2521ade395bfe7ccab04aeb419f14571346e9f6664df6f4733a836fbaf"
    sha256 cellar: :any_skip_relocation, catalina:      "03719e953db671e720983d0907198006958cc5074a0b6191b883cb7530df83c5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "11380d18a6fd7ee2495528b4ed7f2c7c31793bd53aa8bf906924756459f41acc"
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
