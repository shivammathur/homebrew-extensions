# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT85 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/86727b0b05b5d0a9c4fb85021f05d7931e2c3a35.tar.gz"
  sha256 "068b206f63cbb1f9512b9d16d349bbf11d266e84ce7609496b16105c380ee9fb"
  version "3.4.5"
  revision 1
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_tahoe:   "d06eae296d4db49798d30d72936a90a56d1ec87b37502ddebcb01fbb3eb02b34"
    sha256                               arm64_sequoia: "9ad2f4a02690276e6b36b314a712b048f0d691217e44e9bf605b886f67d64233"
    sha256                               arm64_sonoma:  "aacd17477e5df78d9331fa69caa58185ead1536873e4154f257287df0590d799"
    sha256 cellar: :any_skip_relocation, sonoma:        "41046a270b848b2394728b63d0f2f3bbcd1172912d56b266538b4abd8c3c59e8"
    sha256                               arm64_linux:   "c8221df0a583b6330d1351333027f45f20b2a9a010f496de90983da69859ea91"
    sha256                               x86_64_linux:  "a92873d722e678f88e4bcba94e2bd50ac21dc31115f48268dd5f362ea163b8fa"
  end

  uses_from_macos "zlib"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
