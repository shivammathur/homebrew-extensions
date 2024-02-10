# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zmq Extension
class ZmqAT84 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sonoma:   "0daeaff0299ed369fd5478dbdf63a7701527920517e7c2491602b7759c45a6f6"
    sha256 cellar: :any,                 arm64_ventura:  "cf02988626d0e9f89f6a6c61c7eecf051e1543de7219643a41f65ff342cfbaf1"
    sha256 cellar: :any,                 arm64_monterey: "c2209373efa34196f44d7f6f4f88d622cf54426e81c3eebadeda0e0be2592fb5"
    sha256 cellar: :any,                 ventura:        "32b4520b13e9e1f1c1a177312d714ce730f826f826d23d0b7cb769298cc4e415"
    sha256 cellar: :any,                 monterey:       "ef40f5ed59deb2faa141e21960387cfaf3106a8dc0586d23c642c702ca017a7f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2b6d61d1914ab58eebcd942db966645790eacf50bc0284ae74f36ac063a90e94"
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
