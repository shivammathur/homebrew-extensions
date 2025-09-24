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
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256                               arm64_tahoe:   "d6422246011e0d4ca000c6afee290b6de0ec21b3bd363e3003d466ccc126b47d"
    sha256                               arm64_sequoia: "3b6869f1a8b7094660cef34e2b54f286dc0b6e67d82230c1ccc10ac0dd4c10a9"
    sha256                               arm64_sonoma:  "688385bba5f0c515c4ebb1092f714d04598de3ab3753fda688febba0c3dc1b5f"
    sha256 cellar: :any_skip_relocation, sonoma:        "d3ac2d5527e4d1a6da88e3be04f4b8c955e0e5cdd8184dd5acfd871e8830b75b"
    sha256                               arm64_linux:   "a8f4b547dc18298bf1401385f14b1cbe58e426c0c9c64c14a8295c8e5eff1dd6"
    sha256                               x86_64_linux:  "d3d109123b60005e733f4905179f94f7fe3cce067770c71e8fa958a61de4f443"
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
