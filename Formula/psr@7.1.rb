require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class PsrAT71 < AbstractPhpExtension
  init
  desc "PHP extension providing the accepted PSR interfaces "
  homepage "https://github.com/jbboehr/php-psr"
  url "https://pecl.php.net/get/psr-1.2.0.tgz"
  sha256 "9c3d2a0d9770916d86e2bc18dfe6513ad9b2bfe00f0d03c1531ef403bee38ebe"
  head "https://github.com/jbboehr/php-psr.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "62dd91da91914ad6d8bc2577e2cb63488d5a60371c13642c355fc3cbd9b4a2ed"
    sha256 cellar: :any_skip_relocation, big_sur:       "5d7f7b93b800634cf21d906f1bdf3e136a43394be268b52c5afa58f4f9fdfd82"
    sha256 cellar: :any_skip_relocation, catalina:      "1deaae07490c896ece32d55ba3f6d5a9e38797d0d96066e693584846356d5b89"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "70d7d4de1aece679a04721255787d4f29f70a65a5b08ad3dff26bf4844f61495"
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
