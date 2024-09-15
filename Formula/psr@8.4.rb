# typed: true
# frozen_string_literal: true

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
    rebuild 3
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "b7bb32d9fed7eb5137be6fdf09025528061dcc113747d8607ce4daadd8d77fe9"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "11ae5ff3d89691e8e75c898b474fd1c3c57107e1dca57446df440ff25d98fb87"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "fce735b494af238afbc58c0d60c9b443e8cb98924f38f8e18129fcd67eb5bc1f"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "b15df51bf411c8367870ace6f129e0a5c8bc2a8731ed57f8b581c071de9b9d6c"
    sha256 cellar: :any_skip_relocation, ventura:        "c15e3821fd39596044f813b9942ac4439f605d0c026dc9eaed5253add2d9da49"
    sha256 cellar: :any_skip_relocation, monterey:       "c1b206db94c5579b54247cccaabc135724e35fc2073de5e70574ae3e12a526fc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "20455b55f709c11d75526c8f4e737dba0790ba7b0529d7765548ed08f9042187"
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
