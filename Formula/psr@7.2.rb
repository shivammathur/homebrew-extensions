require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class PsrAT72 < AbstractPhp72Extension
  init
  desc "PHP extension providing the accepted PSR interfaces "
  homepage "https://github.com/jbboehr/php-psr"
  url "https://pecl.php.net/get/psr-1.1.0.tgz"
  sha256 "4feb8eeea4237894bcab1ea064cefc3421c909778d39c977184c16e725cfbfb2"
  head "https://github.com/jbboehr/php-psr.git"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "1174d0390fa8ebdad9c352490709e5e9ba5a3c26307bd662a6d44735bb653b51"
    sha256 cellar: :any_skip_relocation, big_sur:       "6f628e993bd86d669febb15b30017def78885cda5a2e861b223f355090a32844"
    sha256 cellar: :any_skip_relocation, catalina:      "7631d58de4468f14c478545ec51cde02dbb71c1b14f5bb63eb494d96f46434bd"
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
