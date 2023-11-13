# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zmq Extension
class ZmqAT72 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sonoma:   "fb51c61b942dedf389a1987c3adeb33b0c4369a9eb47ee4af01e5264e63ee4d1"
    sha256 cellar: :any,                 arm64_ventura:  "e8be806e786ef355dc9e564258b32161404757632be9465e1359bd24f4dd6557"
    sha256 cellar: :any,                 arm64_monterey: "1c0ff75443115e76adaf38365a0fa290674bad42b4665010e07f82395d0d3656"
    sha256 cellar: :any,                 ventura:        "60cee82381c8f879aefab52252ea8ec3b2afdd2f14a29d2b59d91cccb7553ec0"
    sha256 cellar: :any,                 monterey:       "e7f837a92ccf3cd789df6ce39b6f60321fc2e7d23cf2ea976513187e64e53acc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "168d586891d3e865fdfc0cddf8d5e25d2663d134b11845cf18e01312c78201e7"
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
