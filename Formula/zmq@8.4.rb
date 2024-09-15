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
    rebuild 5
    sha256 cellar: :any,                 arm64_sequoia:  "19181c12fddddb64e4a7386fe11b1e2e13b123b6bc3fae938196f24a582bea5d"
    sha256 cellar: :any,                 arm64_sonoma:   "041391cad8afb3df2d2a920ac13c16f1f057257fea5c0e9256ef2e23ce89e203"
    sha256 cellar: :any,                 arm64_ventura:  "d73f82a8c620b398883cabc67d8554a649c78d2a190468aa9daf62a59fa08e7f"
    sha256 cellar: :any,                 arm64_monterey: "3741fed927de305f89811b251ad71d606521bb48d02b800e95adc33e273a84d7"
    sha256 cellar: :any,                 ventura:        "4dce443c74aaa6089225390545232ca8580366fded0a78e0f4d089690c03d82f"
    sha256 cellar: :any,                 monterey:       "642d1f589bc8d9720c06bb3291e3f6787d5dea7caa3d14c2831e445ec698afb2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "043aded4019ea6b73be23d8e656962dc2206e2c9b09ca375c64ca910697d0e2e"
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
