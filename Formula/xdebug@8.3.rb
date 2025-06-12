# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT83 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.4.4.tar.gz"
  sha256 "e906c231812ffd528f3dadf10070f469d82e392458a733a3e50dba7021e43034"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sequoia: "7737b791a8dca2dda84b29174fcc81d98b4e415990b0892d6add10dffd11fcb9"
    sha256 arm64_sonoma:  "cbd0fd226514fc9d3e885d0343d33bad01075b48ebca25090a8f03159622eab8"
    sha256 arm64_ventura: "58716047ee89cb8aed5376104f7a80ab0e5c2767226d7e48a762d92afa4af62b"
    sha256 ventura:       "6241dab123ed3793018db5aae9260b10795eb54e6bf8dbab1b7e7c716c095a06"
    sha256 arm64_linux:   "d399cb6e981c6ddedd463167d3770758ba032ffe5a0245d123eb1e47e3798a5c"
    sha256 x86_64_linux:  "68c128395bd11af479b9430766b6cb687fb556277f80db00081cabfa9fc48ad3"
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
