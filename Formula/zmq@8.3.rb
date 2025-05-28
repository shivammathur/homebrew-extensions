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
    rebuild 6
    sha256 cellar: :any,                 arm64_sequoia:  "bccae1e1ad474b4b383f9013dcde8358b8fac73673ff1274f0d69ffdb784938e"
    sha256 cellar: :any,                 arm64_sonoma:   "f9b9d023ea340bf93e81bc08cb2d34ad2ea3748431c8d6f6819e9b988d2a3506"
    sha256 cellar: :any,                 arm64_ventura:  "ec1e1f900bcc40aedfa084b4994336f7e7bfcc956e1919558036081b358ee5f6"
    sha256 cellar: :any,                 arm64_monterey: "855a34d1ce27488a572172a4e4a45b05bb7a626b23b2a4f570403c2366a429a3"
    sha256 cellar: :any,                 ventura:        "dc732bd37594c87ee2a8c4f59479d08d65b9e28873dc81ba7b506a2e19c117e4"
    sha256 cellar: :any,                 monterey:       "415b004ae5d9dde70e44d8ae8731712177d2e09fc8a217e6099b8f5e4df3380d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "14adf691cc818de518a3da089df1269fae87c5d46a93e8deb575c2a749b1958f"
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
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
