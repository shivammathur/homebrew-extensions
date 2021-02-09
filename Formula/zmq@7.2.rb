# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zmq Extension
class ZmqAT72 < AbstractPhp72Extension
  init
  desc "Zmq PHP extension"
  homepage "https://github.com/zeromq/php-zmq"
  url "https://github.com/zeromq/php-zmq/archive/43464c42a6a47efdf8b7cab03c62f1622fb5d3c6.tar.gz"
  sha256 "cbf1d005cea35b9215e2830a0e673b2edd8b526203f731de7a7bf8f590a60298"
  version "1.1.3"
  head "https://github.com/zeromq/php-zmq.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    sha256 arm64_big_sur: "1cac67dec751f0dc6017e6ca2565f8d3428d1cdadc84cb34facc327dd1dcffbc"
    sha256 big_sur:       "e8b41d757fc234b06dfaad4c48cf882f8b31cfe483a8f5d730e8e6bbe0c3e955"
    sha256 catalina:      "840773948567ddb3c8059cea8d888c8d4a3b8bc33683bf10c8d00e384d7f5f19"
  end

  depends_on "czmq"
  depends_on "zeromq"

  def install
    ENV["PKG_CONFIG"] = "#{HOMEBREW_PREFIX}/bin/pkg-config"
    ENV.append "PKG_CONFIG_PATH", "#{Formula["libsodium"].opt_prefix}/lib/pkgconfig"
    args = %W[
      --with-czmq=#{Formula["czmq"].opt_prefix}
    ]
    inreplace "package.xml", "@PACKAGE_VERSION@", version
    inreplace "php-zmq.spec", "@PACKAGE_VERSION@", version
    inreplace "php_zmq.h", "@PACKAGE_VERSION@", version
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
    add_include_files
  end
end
