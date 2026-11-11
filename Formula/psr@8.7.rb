# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class PsrAT87 < AbstractPhpExtension
  init
  desc "PHP extension providing the accepted PSR interfaces "
  homepage "https://github.com/jbboehr/php-psr"
  url "https://pecl.php.net/get/psr-1.2.0.tgz"
  sha256 "9c3d2a0d9770916d86e2bc18dfe6513ad9b2bfe00f0d03c1531ef403bee38ebe"
  revision 1
  head "https://github.com/jbboehr/php-psr.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/psr/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "035c1e4c4457c56607d1cf0118c05a43bbd456725549561505058798baee22de"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "678bdba829a251838e1fe63b22701ae57db1a4ae79c2cb16f21f5239966ba023"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "dbce732760afda268265ed1f6ae6ea84157e7af55391a557760b692dea0cf3a7"
    sha256 cellar: :any,                 arm64_linux:       "62192f8f16bfc22f6fe7b9d3a1392e1d866924ce47fa64260ea7b1f52d31b3de"
    sha256 cellar: :any,                 x86_64_linux:      "bd1de1b6df920502a88818c0ea74197aaad2036364f9c600e2524e76c87b8ca5"
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
