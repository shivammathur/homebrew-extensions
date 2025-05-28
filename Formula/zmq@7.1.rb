# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zmq Extension
class ZmqAT71 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia:  "8282fab3d484f7c58a139ae9b9c8097dcb17c5f72eb2b255d958e906870f793d"
    sha256 cellar: :any,                 arm64_sonoma:   "c1cc888253a3840de7253fe714a4bf58b025b518f1149f5d5a00d787f41967dd"
    sha256 cellar: :any,                 arm64_ventura:  "a5d5291f4b8a0753134ffa44a8e8c566f6255a7bcc319300b6b2223b46059254"
    sha256 cellar: :any,                 arm64_monterey: "cd83fc84e4cbfa451851d14048fa6137cf2eba13064b0ebd898b16e0447e4ba7"
    sha256 cellar: :any,                 ventura:        "0c31d4bb78240f8f1cb6ae7aca589276a7d5498b685c147c2877b8707980c3b9"
    sha256 cellar: :any,                 monterey:       "edafd84114f7e1c7c155dd24dc0ae3a1d89aa3f0e24c180bfd0a83bab628da59"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "695ddfe328fe3f5ba3741d9d7b1979c51a2a3a0869e8d1d15331df29826071ed"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e3644cc14fa505a35414b25dff0449354d84ef280145ea84ecd9cbd2f7d4dab0"
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
