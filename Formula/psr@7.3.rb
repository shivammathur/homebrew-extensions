require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class PsrAT73 < AbstractPhpExtension
  init
  desc "PHP extension providing the accepted PSR interfaces "
  homepage "https://github.com/jbboehr/php-psr"
  url "https://pecl.php.net/get/psr-1.1.0.tgz"
  sha256 "4feb8eeea4237894bcab1ea064cefc3421c909778d39c977184c16e725cfbfb2"
  head "https://github.com/jbboehr/php-psr.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "ff98226e520133721b8bc972ee915e15bc022dbbdab699c3f04dff05d87f2a19"
    sha256 cellar: :any_skip_relocation, big_sur:       "69349fec904d591870fbabbedfa52616597e16bd59f1a9b4d2d6c694522c4af9"
    sha256 cellar: :any_skip_relocation, catalina:      "6536c6a3ed3c1411ccfb268d560674f5aa73c527fee2f9435b03fc710cb56fa2"
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
