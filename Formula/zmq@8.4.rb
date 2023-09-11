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
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "40f0296ab5ac70417d8e4091e6f9116b11b4708c33e6d07a13c52065c6af8700"
    sha256 cellar: :any,                 arm64_big_sur:  "da7b3928609f16c1bc5202ebeed304abc4784edc096649ecab84e821b1242b5c"
    sha256 cellar: :any,                 ventura:        "a583400bf3e31c8b8440a1d927716c9b22463a616bd013fe0b0086af075fb33c"
    sha256 cellar: :any,                 monterey:       "0afbb9bde2ed1bac2f6f17714cd70dc1c8f831bde936dcca91f575e9742d4cd0"
    sha256 cellar: :any,                 big_sur:        "85b9b3a57cbd45d6fb977118b5c66b01d095fcbb078b2a92f324de9a6514e278"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "27fc90fa59e6496347ceb60aee8e5bf0c78d2e63be7096b1d9e2d9a9dc9e02aa"
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
