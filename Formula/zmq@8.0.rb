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
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia:  "e7f4c23f29be0ffe84a5eef4222c90bab05e24e0650afd43ab543eaf5c9ef284"
    sha256 cellar: :any,                 arm64_sonoma:   "bfea70f5686a161f9431daf230c98a95b1ba8a3401c82706c61b4f3c04d02e1f"
    sha256 cellar: :any,                 arm64_ventura:  "001587d25dde9a6f15943fe2638d3b246972c92b30fe55e5f40c8dd16b5dfa8e"
    sha256 cellar: :any,                 arm64_monterey: "a673e8ed5073316d28b803637a3d80f2ddf5d745190e4b0dff4cb0cfe40ad62f"
    sha256 cellar: :any,                 ventura:        "cc35a150d99c96adc1fb4498384606b289cd7114a4bfbc0b30ac7d0a93cbb383"
    sha256 cellar: :any,                 monterey:       "f7fd11dbfa70359261345cf7e7be7f526caf369af029fac9ea378e3c2be33ac1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c70c01f05ae0efffa0595ba8e9b5d74a18e2f5b567a0e444d8baa720b6998c3d"
  end

  depends_on "zeromq"

  on_macos do
    depends_on "czmq"
  end

  def install
    ENV["PKG_CONFIG"] = "#{HOMEBREW_PREFIX}/bin/pkg-config"
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
