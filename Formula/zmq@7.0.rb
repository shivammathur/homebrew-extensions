# typed: true
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
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia:  "5d11e66f4c4f8667a21e14e7bec54ea1f124db0100d6cf54cccec68cd66ba032"
    sha256 cellar: :any,                 arm64_sonoma:   "e0461c8cd61189724d1b0e58ec960ccb38046b23296b22caa002e5c9bfda879c"
    sha256 cellar: :any,                 arm64_ventura:  "9be5bf3bde61ac4a81a3202e5cb1c3bd0e20b8e83bfa8dc0f16b80583191c8ec"
    sha256 cellar: :any,                 arm64_monterey: "4725c4fc4158bcbe976870e7352199a24fb58333272550649784853fa6f1f881"
    sha256 cellar: :any,                 ventura:        "9efd5336f20f59f500ae8b63a30b124f7b82a747d66373d5029d93584a7763e1"
    sha256 cellar: :any,                 monterey:       "306d59c106c62e7785d40bbbf5d5fd1d25230c77a8ccc3c0b56bc5da950aa39c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d74fa650126d46dbdcd1fc716afe4b537e62e0d18cb778d0bc46630026e6fc57"
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
      --with-zmq=#{Formula["zeromq"].opt_prefix}
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
