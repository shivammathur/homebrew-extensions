# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class PsrAT87 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "b78db84bd2cc81799ffc311f649331ed457054e58aeb9f727cbdcc7a68a73817"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "2e7908fbbe938affee51f1749af41aab93c6be6ae586d81fabd2481c2e95e127"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "a030d19d04454a7c15562ce367e91fbc6f87e68cc5d17f60335ce826a6439237"
    sha256 cellar: :any,                 arm64_linux:       "d147af4cccaf46916de7777ede301207d731f91b32f5bd33d1e0975512925e22"
    sha256 cellar: :any,                 x86_64_linux:      "f28cfaae9dec82b2262bb4ed9f1b0776f7db78c8967dc8bddfea4180ec59d84c"
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
