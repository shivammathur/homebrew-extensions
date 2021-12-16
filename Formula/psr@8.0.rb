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
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "e7b1538d8b8a6c3e9a6834e25bfd0cf7e308d148f1c8fa5e1d940b12635006a8"
    sha256 cellar: :any_skip_relocation, big_sur:       "f4fbd8460236574933e6e296733696c2b0350c7250923332f1e34284c89d6c48"
    sha256 cellar: :any_skip_relocation, catalina:      "a529370513eccffdcc557bfa0de407a5ce15c2ed460356829a4e468f07e1ec57"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a165d231533df26edfb60812257470d1b5581207c979ba9b8cf50e0e1cd382f5"
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
