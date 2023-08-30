# typed: false
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
    sha256 cellar: :any,                 arm64_monterey: "8d79560a6db34fcc234b9271a9f1d1bfc33bdc0d253a0071090ad456b5d15b1f"
    sha256 cellar: :any,                 arm64_big_sur:  "a78ffb9e5450f49b9f3e6537e632fe02aee5084aa7d48255038d41163c7e129c"
    sha256 cellar: :any,                 ventura:        "07bb554b02d7969ab9aba01fe66403f94488cfdb89a0a210e3d2ba56a4318375"
    sha256 cellar: :any,                 monterey:       "a5aa7cb19c6108d08bcb0e9a7772975a1f2d031e84d8a235cea0f163a5ff736d"
    sha256 cellar: :any,                 big_sur:        "6d0701cfe3ad1127126760af072a2324d85b8ae29d924c8e2f72359845128ebf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c2052d4cf50c5d123487470e45138e70c46745257339cc2d8a29967203e376ba"
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
