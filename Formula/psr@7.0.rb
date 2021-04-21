require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class PsrAT70 < AbstractPhpExtension
  init
  desc "PHP extension providing the accepted PSR interfaces "
  homepage "https://github.com/jbboehr/php-psr"
  url "https://pecl.php.net/get/psr-1.1.0.tgz"
  sha256 "4feb8eeea4237894bcab1ea064cefc3421c909778d39c977184c16e725cfbfb2"
  head "https://github.com/jbboehr/php-psr.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "ddf7a04011c16419ecb42ad7612bfc13579137ba6eb8a89523e90a086c278673"
    sha256 cellar: :any_skip_relocation, big_sur:       "e312a44a5a785d5beab54d3434eb7f3aa4a6ec7408c2ea255f975a606b7f974f"
    sha256 cellar: :any_skip_relocation, catalina:      "281956113992a7c38cd80b672200f7deed6e586587acbb0d4fa2ade0a6d4273f"
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
