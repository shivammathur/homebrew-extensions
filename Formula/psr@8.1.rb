require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class PsrAT81 < AbstractPhp81Extension
  init
  desc "PHP extension providing the accepted PSR interfaces "
  homepage "https://github.com/jbboehr/php-psr"
  url "https://pecl.php.net/get/psr-1.1.0.tgz"
  sha256 "4feb8eeea4237894bcab1ea064cefc3421c909778d39c977184c16e725cfbfb2"
  head "https://github.com/jbboehr/php-psr.git"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "389169cef2870aa42d4089e07dd8299b18b1995bc70e1e4b7307b4f4372fbfc2"
    sha256 cellar: :any_skip_relocation, big_sur:       "b1a96ef065598f0158702c3cc4ba4a1c6fdf48ed7334a455092ee9cfa369f5b5"
    sha256 cellar: :any_skip_relocation, catalina:      "52666e479f531e37a03e79a6a4253401f8b019ea812740ccc713b109c388c722"
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
