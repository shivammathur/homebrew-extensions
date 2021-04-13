require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class PsrAT80 < AbstractPhp80Extension
  init
  desc "PHP extension providing the accepted PSR interfaces "
  homepage "https://github.com/jbboehr/php-psr"
  url "https://pecl.php.net/get/psr-1.1.0.tgz"
  sha256 "4feb8eeea4237894bcab1ea064cefc3421c909778d39c977184c16e725cfbfb2"
  head "https://github.com/jbboehr/php-psr.git"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "e7b1538d8b8a6c3e9a6834e25bfd0cf7e308d148f1c8fa5e1d940b12635006a8"
    sha256 cellar: :any_skip_relocation, big_sur:       "f4fbd8460236574933e6e296733696c2b0350c7250923332f1e34284c89d6c48"
    sha256 cellar: :any_skip_relocation, catalina:      "a529370513eccffdcc557bfa0de407a5ce15c2ed460356829a4e468f07e1ec57"
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
