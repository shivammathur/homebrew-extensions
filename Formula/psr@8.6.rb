# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class PsrAT86 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "24d571f2123c708ee751cff2f65ddccd647cf45b51397a72915aa13febdc5139"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "7ef42d2eb058f12f564d07e965ae71986cae46f8acda8ffd310329a45a796b4f"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "6a72519f25e77aa99dd491bf7a05ae7703338dd47e8e3eeb8a8b2ff06eaadb38"
    sha256 cellar: :any,                 arm64_linux:       "93a8a2ff7b2f1ca241c93b315c8961d35d6146d19cae5cf7cd9a1c8193b4a525"
    sha256 cellar: :any,                 x86_64_linux:      "ea2f57d556635b8e0709d5012dd0e6b7711509e290953ec859d610a06672a2dd"
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
