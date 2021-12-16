require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class PsrAT82 < AbstractPhpExtension
  init
  desc "PHP extension providing the accepted PSR interfaces "
  homepage "https://github.com/jbboehr/php-psr"
  url "https://pecl.php.net/get/psr-1.2.0.tgz"
  sha256 "9c3d2a0d9770916d86e2bc18dfe6513ad9b2bfe00f0d03c1531ef403bee38ebe"
  head "https://github.com/jbboehr/php-psr.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "bbc77358f29527d196bf6014132072ac555bc4500536129d824ec8adc6d27305"
    sha256 cellar: :any_skip_relocation, big_sur:       "127f68e9430ff0a3ea46e0a50540ce91852a648819244a30a99114b4ab42312e"
    sha256 cellar: :any_skip_relocation, catalina:      "41f647f4756d28c9324d5a75cce5de24a43daf8abcfb6c61e4562f8bf561977b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2a6586bd25a9d01be1b829ae484446e9fd77bf378e66b4eef19187df767e8400"
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
