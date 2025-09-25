# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class PsrAT85 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "5f20b263aeb167b7a4cfe3dfc2e947399588f0e26d85fcd619558e62142c9479"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "ed66581a80aeafada3bab4601adccf1e2cec4e6611e25e6b33017878b9015174"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "0e09e0f33d5ab8ed75d76e3cdc22b3648d963b9886ae4b6678614073189e4265"
    sha256 cellar: :any_skip_relocation, sonoma:        "e62ceb35133caaaaab41be2f115b3a342703707df4f62dbc3bc0983bd6ba4a4e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "f205722324b41df7d1b24f0ad964f32ad19dce5f76ae09d817754fd156e2853b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6e24b054d52d5adae8c0ad741b095fcd5f2331159695dc0e1ba7adb7940bdf42"
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
