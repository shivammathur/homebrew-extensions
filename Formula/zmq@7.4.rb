# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zmq Extension
class ZmqAT74 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_ventura:  "c4805af1c9bb757cf78e4a81ebaae76a195d1d69ffcff1bf2f52e94482474ab2"
    sha256 cellar: :any,                 arm64_monterey: "3722210310d469d5cecd6f8713e6a1d3a06884288684ac21f6717d5640449858"
    sha256                               arm64_big_sur:  "8845372eaa9b9e6c4f82f36cc938f025be0694a24c432c8bb58136529cac231c"
    sha256 cellar: :any,                 ventura:        "ce39c145cdda15a6a26d6e5eba8b4f7c81cbb41d0234b5a7c72019bee2ec36b1"
    sha256                               big_sur:        "0c79a553843b1d11c5f7c21f996d8b5579e863d4d12dec8349fc0207bb304cd0"
    sha256                               catalina:       "38594d08474f2146930144c34be9383366fc54ee1412b37281d9a1f27fe45f41"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5d8f48b2242b382a162f32972c61b7c192b315a7aeedc95bddf65fbc3e1b1580"
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
