# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zmq Extension
class ZmqAT83 < AbstractPhpExtension
  init
  desc "Zmq PHP extension"
  homepage "https://github.com/zeromq/php-zmq"
  url "https://github.com/zeromq/php-zmq/archive/43464c42a6a47efdf8b7cab03c62f1622fb5d3c6.tar.gz"
  sha256 "cbf1d005cea35b9215e2830a0e673b2edd8b526203f731de7a7bf8f590a60298"
  version "1.1.3"
  head "https://github.com/zeromq/php-zmq.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_ventura:  "a4ca46f6763f0d7246fec65d47fab8eba49e12f953c20138a932ca99612c20f7"
    sha256 cellar: :any,                 arm64_monterey: "8d59d1305dd8f905815d2d3bbf26a240137f4ad9eadd0647ffaec7439e1847cb"
    sha256 cellar: :any,                 arm64_big_sur:  "a77915d34edc40b37c04fd287f3061887706ff3064bd51938b4a581d0444a66d"
    sha256 cellar: :any,                 ventura:        "6177186e7291ef41c275f65b15095aab81eb6fc27e01fd4229e5470178b15fc3"
    sha256 cellar: :any,                 monterey:       "d9f43393cb7e51af40a2c1a3b0963a65afde68522f65419776609f7c97928fb2"
    sha256 cellar: :any,                 big_sur:        "eb2f96101a1a8249522ef69feed755aea5483e1f5386bfa24c0e48a6fc21d6a4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e46f68dabe059ffae2e52728c5ffa5b19bffbd6e5ca692cc10f7564ecfd1b3c7"
  end

  depends_on "zeromq"

  on_macos do
    depends_on "czmq"
  end

  def install
    ENV["PKG_CONFIG"] = "#{HOMEBREW_PREFIX}/bin/pkg-config"
    ENV.append "PKG_CONFIG_PATH", "#{Formula["libsodium"].opt_prefix}/lib/pkgconfig"
    args = %W[
      prefix=#{prefix}
    ]
    on_macos do
      args << "--with-czmq=#{Formula["czmq"].opt_prefix}"
    end
    inreplace "package.xml", "@PACKAGE_VERSION@", version.to_s
    inreplace "php-zmq.spec", "@PACKAGE_VERSION@", version.to_s
    inreplace "php_zmq.h", "@PACKAGE_VERSION@", version.to_s
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
