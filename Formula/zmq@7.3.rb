# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zmq Extension
class ZmqAT73 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia:  "9060710138d86ec54bf598552d457aa53c82555c53c815654a5e5e283c6d5bcd"
    sha256 cellar: :any,                 arm64_sonoma:   "f54e5a7f52057ffe1205e97462de97844744de7ef259edac278211c4ab94ddcb"
    sha256 cellar: :any,                 arm64_ventura:  "42e5a8f6499b450bcf181d725be362dda1bc4965ac1fc95de7667f148f594c87"
    sha256 cellar: :any,                 arm64_monterey: "a3b1333f99f412658db97f1e6dea285953f7249f86bc6e551af4ffbe9dcb434b"
    sha256 cellar: :any,                 ventura:        "338f89388c486810076aa2f1f190dab8f7316d1fe83aa89e8bc0c136579e200e"
    sha256 cellar: :any,                 monterey:       "e6f83ab443057f83d900a2ae1bd4f0f2ee72e36bc2bd0350f2ca53eced82b81f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0f8c1d805afc1a8dd2925c32cb5ff5114b1ccfbe823a851042401da5c3d9205a"
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
