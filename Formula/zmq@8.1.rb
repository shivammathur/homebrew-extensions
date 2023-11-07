# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zmq Extension
class ZmqAT81 < AbstractPhpExtension
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
    rebuild 13
    sha256 cellar: :any,                 arm64_sonoma:   "eddb6257bc7b6f0678a5f69894865a82889b5ed95faa6e33d253bf3448848f59"
    sha256 cellar: :any,                 arm64_ventura:  "1c90a48c0b5746224eb7ddfe48af06dfc2e635d115aa47fea355fd5f3e14b67e"
    sha256 cellar: :any,                 arm64_monterey: "8ca3958b0ff075533e8cd2696c01bdece20330d4ef9851db745e122292ff9c77"
    sha256 cellar: :any,                 ventura:        "441ef235db39f13455ec1ba64a591a9f9bacddbb6f5ab9192b1c09b7f44c523e"
    sha256 cellar: :any,                 monterey:       "dadf017d89d1e26c5eab3e2758c7101ef81675ab2dbd7da2cae7c9d11c98608e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "80f623b14ba731378f582718f133c6b9186bf0bad302df797b6e3fccee2f00d5"
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
