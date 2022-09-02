# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT83 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.2.0alpha3.tar.gz"
  sha256 "10fe3f5bb20ed104fa55e11e2c8616bae94fbd8286b3f2388639decbfe7dfacb"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_monterey: "ae60b6026cd9df5c258170d2da042127ff0052f00771cae059a1125defcb9be8"
    sha256 arm64_big_sur:  "fe2e0312f7f0ef7e0a8cda7a8c86a3e3c7d58368119333e992edba420582a972"
    sha256 monterey:       "f64e9ac7f43d830031f70039c519c842a0b018820757bbcf282c90f193ce292c"
    sha256 big_sur:        "5f99be1d723140b6c744ff2117bb8fd382ba0f22e1db7e0585babbbb75dd1520"
    sha256 catalina:       "54035f21998f5e67d7d6c18bc749e91a34864f9cd7cdff30bb3bc2129a01ab02"
    sha256 x86_64_linux:   "0d7293c493cc1211ed959b32a1c3cac98543da05e279a9b8fa892ee32742c4c0"
  end

  uses_from_macos "zlib"

  def install
    inreplace "config.m4", "80300", "80400"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
