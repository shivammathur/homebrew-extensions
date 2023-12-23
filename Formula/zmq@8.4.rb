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
    rebuild 3
    sha256 cellar: :any,                 arm64_sonoma:   "6744131d9c55fa28d4e033fad17624642932174ea0760c553b0e9001a1b695fb"
    sha256 cellar: :any,                 arm64_ventura:  "c47c43e72602a528acd1b2d9415e5e6ad13f8537882936117ab0d6a08ee1484a"
    sha256 cellar: :any,                 arm64_monterey: "4694460c755859b04f648b50637413f226e5809514fccef9972213e313c7a1e7"
    sha256 cellar: :any,                 ventura:        "3df29e7d4417d1bd259a0cc2f00d0acf86f2ee35bab1f76b410fcf3ba3c5922e"
    sha256 cellar: :any,                 monterey:       "75e76056182c8c9528a06c4ba077c7f02e5f225b120b167a2142defa56da8cc2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5d4ad299c2c25c364015d251b55cd171323290a8fbe83797d2d4d0bf5364aac3"
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
