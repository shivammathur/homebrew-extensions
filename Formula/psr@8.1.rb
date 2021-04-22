require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class PsrAT81 < AbstractPhpExtension
  init
  desc "PHP extension providing the accepted PSR interfaces "
  homepage "https://github.com/jbboehr/php-psr"
  url "https://pecl.php.net/get/psr-1.1.0.tgz"
  sha256 "4feb8eeea4237894bcab1ea064cefc3421c909778d39c977184c16e725cfbfb2"
  head "https://github.com/jbboehr/php-psr.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "11736b42cb885b28c28d7a24f93a5d62cb9498d8a984d60bedadaf7930af7557"
    sha256 cellar: :any_skip_relocation, big_sur:       "9ed2334632d2387c8c30524984a982ebe24f61c8a9b78b49c19f3fae4869ff6c"
    sha256 cellar: :any_skip_relocation, catalina:      "48df64b0000fc815ac3c75de36eb812de35e5ad5a44e509f564a29aa630419ff"
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
