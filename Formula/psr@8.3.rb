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
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "81264b5d2237d3c9930dadaa7a2d067ad9ba35bcade1df443e2ba5540f4f694b"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "f61af6725f0b18ece5cbf13d876c4a06daf00a4ab970e68fdc60884de2030926"
    sha256 cellar: :any_skip_relocation, ventura:        "d7165c9c6ae0d81039b8a8b3268333dfb5029f2a7b87873b46e1c382a03405f2"
    sha256 cellar: :any_skip_relocation, monterey:       "934b4519766309e59daeef1dbb90e6b09eccfa13e022f222624688349ced43f0"
    sha256 cellar: :any_skip_relocation, big_sur:        "c09a03ee5b58bd0a03caf22b8a55cb208486d14d6e3b814a6ade47246a1c0130"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5c6c7884d04afdcd7e2661ba99bdf10f2e31a2841a956968180da4895d23bae4"
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
