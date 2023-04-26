require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class PsrAT83 < AbstractPhpExtension
  init
  desc "PHP extension providing the accepted PSR interfaces "
  homepage "https://github.com/jbboehr/php-psr"
  url "https://pecl.php.net/get/psr-1.2.0.tgz"
  sha256 "9c3d2a0d9770916d86e2bc18dfe6513ad9b2bfe00f0d03c1531ef403bee38ebe"
  head "https://github.com/jbboehr/php-psr.git", branch: "master"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "8aff9053dc7684392aad8783fea5c70d3eaed8798ac936acac76e6c24003568f"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "de39dc7a66271e016ff8002371a5757982e37951a569bf1a824f444889d81efa"
    sha256 cellar: :any_skip_relocation, ventura:        "ba073a493be97b4b4fb00369f83343f8520ee551ba1019256f377e9775c13ea5"
    sha256 cellar: :any_skip_relocation, monterey:       "9c2eb061cd80351818bb4e2e270c8c42065ff6efbe9e1fb376e2563505252634"
    sha256 cellar: :any_skip_relocation, big_sur:        "8114918613e39518516cd2c04db2015c777717c723e6805b4353bb38b5fb0f6c"
    sha256 cellar: :any_skip_relocation, catalina:       "f99341afad78b32d7f2d8d4b336cafd8d1e6bbfe12e5f371afc901d28b76ea87"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "69b26126d07b31aa47b4f7dec35bc0881f881d1ce448310f5fc2d552ba76193a"
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
