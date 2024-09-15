# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class PsrAT81 < AbstractPhpExtension
  init
  desc "PHP extension providing the accepted PSR interfaces "
  homepage "https://github.com/jbboehr/php-psr"
  url "https://pecl.php.net/get/psr-1.2.0.tgz"
  sha256 "9c3d2a0d9770916d86e2bc18dfe6513ad9b2bfe00f0d03c1531ef403bee38ebe"
  head "https://github.com/jbboehr/php-psr.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "09f9709c5f6740d7b3133755d0d61d3ec27b0ab0279f04dc84c06503318a0b43"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "293a3b1b6723fcde247409f740f6774572ac1be4198f5d7f0ad726b3a2e81cc8"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "647a26689dc9516dca9cfd64b89544602edb9c61c34bcd18191f346aa435553c"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "dbcc68181a2d012ccf5de71f8ac24444a5cc1f76aee9f46ff1983100acef47f6"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "7a51b5169f9775efdab9feb0eb05de4a6359d001390210457b635705c7f5ea1a"
    sha256 cellar: :any_skip_relocation, ventura:        "b0575d2fe9d9269ea77ddfe42b33652689b0cfcd544d2855efa6174da917a244"
    sha256 cellar: :any_skip_relocation, monterey:       "70f77ec51c8f951f592ffe06e36e8adfe085f5f0fb313dcf006f8a80ff7878bf"
    sha256 cellar: :any_skip_relocation, big_sur:        "9df7f695617e2da12d6280383452169f5cfc8983256fbb67a724b7476ae56e5d"
    sha256 cellar: :any_skip_relocation, catalina:       "8743c0d4cc2c675bf8493a20ec93dfc22f45dfe969df31651b59f6ee07774ab8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5400228e9ca5c4834d6d0dad5d588b8beaedcffcbd081f820c5045d468f0567d"
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
