require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class PsrAT82 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "2fee1fcfaf4bc3d381df932eb7c44811306b395a2e9c961a058bec46c4956cb9"
    sha256 cellar: :any_skip_relocation, big_sur:       "64bd0f60bae1e768ff5b33be8f8132f535b0e90a068c2759bf6d66f34fac0ff9"
    sha256 cellar: :any_skip_relocation, catalina:      "395713ca6f64c14aa268837bd3844e01bb066047cfc23934ca59a2e673811295"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "039c41fa7df1b3fc65a01905b64b2e27292a3a9d405d17b7c4cc6245a87ed6a9"
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
