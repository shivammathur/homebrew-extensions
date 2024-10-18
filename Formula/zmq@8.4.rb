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
    rebuild 6
    sha256 cellar: :any,                 arm64_sequoia: "dffae405908c41f2fd9e6917a1a85e29b3e8b77f6f509a83e0842e2f1f4e110e"
    sha256 cellar: :any,                 arm64_sonoma:  "1a97e2388859bfc7c098e4a7c0d23421c7396fc8005ea2b4e572b51359086814"
    sha256 cellar: :any,                 arm64_ventura: "5274d14661f84c12e57fe986f5f67a3b6f2e815984860559991b81f2c3d3081a"
    sha256 cellar: :any,                 ventura:       "4d0ff86d1eb57b07c2ca91d096552987ab8b053bc8591506789c8e74ac4450a9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a77a06e21de603adc52a68940580a71dc310c309bc8a7312be0e84bd0ed6b5ec"
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
