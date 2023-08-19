# typed: false
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
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "f76f3a8efa302e0a02d3ab57ca3c79b3cb6c86c1be349a7e8999e7072dc40c77"
    sha256 cellar: :any,                 arm64_big_sur:  "ae4e39a49cffd403c530a83a8705b2f74ab38dd276e36950fa190b6c95ab764a"
    sha256 cellar: :any,                 ventura:        "f0c666b2840326cd08fb6b60a627d30ffab2a20c4fd5a2964d20cfb0eb0dfa1f"
    sha256 cellar: :any,                 monterey:       "29ce91eb3c096722451ce418c8b6fc184323f6df4a6f211ed13c876cf5768567"
    sha256 cellar: :any,                 big_sur:        "6035e122202f7ad79ffb2473a109286a2408c1db00120d7e87c1ee9a62c6e387"
    sha256 cellar: :any,                 catalina:       "fa33240ffc0a9a3e1d19b12042971415fde9058bb8cc56ce74975c507d10eace"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8fe94fae4c79310884e4d47d8e3aac1d32c086b815ea909c9c8f630732008e37"
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
