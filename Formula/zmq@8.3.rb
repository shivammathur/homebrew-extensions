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
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "a0eeddfb502522da7a0fda67c21653636334e06a325cffdcbc0dafcb4053d200"
    sha256 cellar: :any,                 arm64_big_sur:  "5a2ac3b1b5116971a0899c465bb7ad4a2c80051cdee2232e867dbcfd61b140c7"
    sha256 cellar: :any,                 monterey:       "8b8b144dc58fc2751be0dfc8876f6517be9e8ec3dab82dbb6ad3a3159029ec86"
    sha256 cellar: :any,                 big_sur:        "6177b9b623d8af88a075cfe8d92ec54fa2538d7b84a7b21e0f40a2565f632eac"
    sha256 cellar: :any,                 catalina:       "f904f1da75c0a3b7335398cef3f274b1a6fc0407e134533f6e8866b4355f0eea"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8e158e5def43907a84e58ec387d73edf02b0292b651bcf6155288ad76f3497cf"
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
    inreplace "package.xml", "@PACKAGE_VERSION@", version
    inreplace "php-zmq.spec", "@PACKAGE_VERSION@", version
    inreplace "php_zmq.h", "@PACKAGE_VERSION@", version
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
