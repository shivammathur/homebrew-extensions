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
    rebuild 3
    sha256 cellar: :any,                 arm64_monterey: "27a61fcd2ce3c8d4b28321d34819ebe74541a6acfad7a4003fab3ceca41ba6d5"
    sha256 cellar: :any,                 arm64_big_sur:  "edf293daf7d1ffad96895c5ec8ba01c5b8a411d49cb0be9098c1c137b49b53f4"
    sha256 cellar: :any,                 ventura:        "54e0c52a1c45867519d5ae21cad1cfdbd63892d1c5a5862c88018fcbadaf4885"
    sha256 cellar: :any,                 monterey:       "785962f578b215ba1e2461f5c0ac662f1c9c45069b2a6adf0c21a91a498c3d76"
    sha256 cellar: :any,                 big_sur:        "e6e2cb4f372a7fe91cb3f63c3f80a347109e881f904d3df22e12dc19438b1f17"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8339478801c61f850a69666686b355d57c017ee0e1d740a6b19ce06c2a71010f"
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
