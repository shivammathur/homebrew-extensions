require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class PsrAT74 < AbstractPhp74Extension
  init
  desc "PHP extension providing the accepted PSR interfaces "
  homepage "https://github.com/jbboehr/php-psr"
  url "https://pecl.php.net/get/psr-1.1.0.tgz"
  sha256 "4feb8eeea4237894bcab1ea064cefc3421c909778d39c977184c16e725cfbfb2"
  head "https://github.com/jbboehr/php-psr.git"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "ad9b3a32a09e306cb7285bede81519a0276194a8e9b527b7044d327d940530cd"
    sha256 cellar: :any_skip_relocation, big_sur:       "e13510b69981ee241d6840180010cf19372da859ab738c19376a702ee30488ed"
    sha256 cellar: :any_skip_relocation, catalina:      "804d7eda726b484ce149fcc3033b322520ae304e0ab816cb3750daf06cc57896"
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
