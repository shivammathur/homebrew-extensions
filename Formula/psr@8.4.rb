require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class PsrAT84 < AbstractPhpExtension
  init
  desc "PHP extension providing the accepted PSR interfaces "
  homepage "https://github.com/jbboehr/php-psr"
  url "https://pecl.php.net/get/psr-1.2.0.tgz"
  sha256 "9c3d2a0d9770916d86e2bc18dfe6513ad9b2bfe00f0d03c1531ef403bee38ebe"
  head "https://github.com/jbboehr/php-psr.git", branch: "master"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "501090d802d6ea3b3a8f56501dd9398f96a1a6c7530cc6cd888d5d8941dd16f5"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "013c2ea97ff8979a3d07043d4a5ca1dc3252db0af5d014dc3894b447b6838e1e"
    sha256 cellar: :any_skip_relocation, ventura:        "e70bd2601e5d641a0ea3cccd76c8abafc03159e67bd01b6bc2711d68f6d17df5"
    sha256 cellar: :any_skip_relocation, monterey:       "0ca942bc16886440e3d2b1e3065edb7de2f77f77c1efd1f691eef49bffe1875d"
    sha256 cellar: :any_skip_relocation, big_sur:        "d304f8dd8157d23f7f19bcf7af471eaf1f6ef6cff61d73cdc02e719489293beb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3eebf70695e556b4154b89a00d16c2563c01766efb5d0c0d0b18d20776874617"
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
