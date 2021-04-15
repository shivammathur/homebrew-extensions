require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class PsrAT56 < AbstractPhpExtension
  init
  desc "PHP extension providing the accepted PSR interfaces "
  homepage "https://github.com/jbboehr/php-psr"
  url "https://pecl.php.net/get/psr-0.6.1.tgz"
  sha256 "57ccc6293ddb56b3cae2620bb3dc00f145d5edb42e38b160d93ed968fcbb1bae"
  head "https://github.com/jbboehr/php-psr.git"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "00acfce6e643073d6cc012f253e7802c12b3dbd2cf05017940d5d0e3cb98bf4a"
    sha256 cellar: :any_skip_relocation, big_sur:       "1fc0953647001eb2b10a2aa85a9c5c27519cab5679ddc5282ebed1908a4ce74e"
    sha256 cellar: :any_skip_relocation, catalina:      "f2529a4c8824202623afbaaa206dee0bb3bcd9540ac128e7bd7396f53df649e8"
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
