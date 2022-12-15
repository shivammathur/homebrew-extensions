# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT82 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.2.0.tar.gz"
  sha256 "a5979f2060b92375523662f451bfebd76b718116921c60bcdf8e87be0c58dd72"
  head "https://github.com/xdebug/xdebug.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_monterey: "8ab9a710198511bc7b27e35f3e9ae9fc2454a9d5409a44689be962004e144a37"
    sha256 arm64_big_sur:  "9aafa001426ca97d040f232d4340aad2ea0d0a93aab25d8513c5cee340178b77"
    sha256 monterey:       "d4e40748bb70ff33445a403ccddb59f371a01c782872222ee477e71304dd4a5d"
    sha256 big_sur:        "afd3a7fa143080054e6c76e48b81d928f31af60bcd92d5be77efb20546fc93eb"
    sha256 catalina:       "4a863120143f1df8eaa411cbc921d311b1cf1da8931a6d1e5ee1245cd530b1d1"
    sha256 x86_64_linux:   "5f547173fce75e22ba64a0611af68f71ac2da4452bac30a25659ed3298a43b8d"
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
