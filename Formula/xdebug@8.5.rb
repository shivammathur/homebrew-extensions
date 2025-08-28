# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT85 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/c8cdfe2f927c6dec0c6e79e73807f86694b0302e.tar.gz"
  sha256 "6efad819e0494c9106ea7503bd6811daddc77aed76b05886dce325120e92293a"
  version "3.4.5"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256                               arm64_sequoia: "69a3beaddd8c02000ca29f5651479ed2172d4db66832b73c474ef5a5382b2fa1"
    sha256                               arm64_sonoma:  "39e9a0b1c5aa991b5573580d31afa03823e0a2cc4e803f5111dc827ab636e73f"
    sha256                               arm64_ventura: "7c08625ae792576f8c86e8c2fec4dc46149caf94dfbdea1bf90b32cd9ad6e04f"
    sha256 cellar: :any_skip_relocation, ventura:       "c4b321974b5b60235db3013c2819ff9582295a0cc126a042509221d9182fd7aa"
    sha256                               arm64_linux:   "2c0c6283345a4cfa21bef4fe5b34fe1f897c9e4fa05849fd4c5c1f42449907b1"
    sha256                               x86_64_linux:  "e95c7fabd5eb8bda91065905a274b9de723e4d07e3ec1af73055cf2172ece4ae"
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
