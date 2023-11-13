# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zmq Extension
class ZmqAT83 < AbstractPhpExtension
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
    rebuild 5
    sha256 cellar: :any,                 arm64_sonoma:   "fc1a870612b2fc9d81cdc295540504d9bff4ced2b0590ac22f2210153ccfd441"
    sha256 cellar: :any,                 arm64_ventura:  "24b149b0c10de7b00288ebb1c4e8072634414d7cb01ae18def12af57e1db057f"
    sha256 cellar: :any,                 arm64_monterey: "130837ab18c944a7f38e9994f27c84e2e977d0522a40bdbeec1c81cbe1153b40"
    sha256 cellar: :any,                 ventura:        "65d4c890bf5073e8d58d87c2474bf7d0d69aca5981d8c2782af770dae4d3ec97"
    sha256 cellar: :any,                 monterey:       "2c3380fde2c0fcb24f528bd8147da9ac1f087478a58e87a2f4eb509048715d20"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ce5f850a59089e09fa86a826da4ab045efdf96e9b48cfcac3000e20d632798b7"
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
