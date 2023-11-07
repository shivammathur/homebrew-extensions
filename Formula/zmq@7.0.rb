# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zmq Extension
class ZmqAT70 < AbstractPhpExtension
  init
  desc "Zmq PHP extension"
  homepage "https://github.com/zeromq/php-zmq"
  url "https://github.com/zeromq/php-zmq/archive/43464c42a6a47efdf8b7cab03c62f1622fb5d3c6.tar.gz"
  sha256 "cbf1d005cea35b9215e2830a0e673b2edd8b526203f731de7a7bf8f590a60298"
  version "1.1.3"
  head "https://github.com/zeromq/php-zmq.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sonoma:   "368977f08642b79ec9cbc75a8b4c2b3db01f9265487175505ab8875a346df35e"
    sha256 cellar: :any,                 arm64_ventura:  "00b5fed23f48262481b80be99789973cf8cafe804eea535ff70ae0c6635865b0"
    sha256 cellar: :any,                 arm64_monterey: "5f71e98f5c03a91a47664e67789c0ca18441b0a3d01b6efe11651624542de6ee"
    sha256 cellar: :any,                 ventura:        "4d0fdc18d3f81ded80a4f639b6eb2283bc5b522dcf4a721ed40071ef9dcc6495"
    sha256 cellar: :any,                 monterey:       "8af97e29ffa40f665972d29c4b5de98f83eae2662af54d96c36eed0407307f27"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "35a60f865cda20004369133062e0379e146168742d7433946a75807da0ee9c5c"
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
    safe_phpize
    system "./configure", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
