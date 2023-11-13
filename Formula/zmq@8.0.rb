# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zmq Extension
class ZmqAT80 < AbstractPhpExtension
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
    rebuild 1
    sha256 cellar: :any,                 arm64_sonoma:   "7fa3dea25f0b70eac5d97f93b103ac2b4513d1e00f30382bfd8d1fa40f8fa8f1"
    sha256 cellar: :any,                 arm64_ventura:  "93bfbe66a141cb03282fcd8dbaeacb7ac3ed4c21b24a39df8a36fc67a4191739"
    sha256 cellar: :any,                 arm64_monterey: "46e60db6a66f701bcd62265dfb88f52512dab76ff1ae8ed668feec28e8242083"
    sha256 cellar: :any,                 ventura:        "3deef6d18f18f3b6504b7bc2c773a8bcde5dae93c51e3a831234556466be55d4"
    sha256 cellar: :any,                 monterey:       "904ff6575178120b3db45bb69fe81307cca52c69dd22f68370a679183f219eff"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "967e1d56bf7c58eabd3d393889a0de35e38c7d592b975758608039a9553cfb32"
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
