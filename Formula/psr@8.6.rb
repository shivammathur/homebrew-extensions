# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class PsrAT86 < AbstractPhpExtension
  init
  desc "PHP extension providing the accepted PSR interfaces "
  homepage "https://github.com/jbboehr/php-psr"
  url "https://pecl.php.net/get/psr-1.2.0.tgz"
  sha256 "9c3d2a0d9770916d86e2bc18dfe6513ad9b2bfe00f0d03c1531ef403bee38ebe"
  revision 2
  head "https://github.com/jbboehr/php-psr.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/psr/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "d7c46ba9927459ca204209305e830d2d8482f6d9b9efc4d45fab4363f4577d14"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "67bf92f925870a416e8a288541607f6d0702f743c388feb59bc873a38f57b277"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "8a5ccc4859e4e21de28fc11ba2f39207cfab97b456ebfbbc7581fb302c48d27f"
    sha256 cellar: :any,                 arm64_linux:       "3256eaa992e31e89d3c470df50617e6698f2394dd6ff1cf1916814d46d2dbf21"
    sha256 cellar: :any,                 x86_64_linux:      "fa6d7bddb7a3982a8e41411911b013cfe70795ba49958590038ba863a89de6bd"
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
