# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zmq Extension
class ZmqAT56 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sonoma:   "63d7baa78aad3420e44ceae0d509ecbfc083ed23d8a292a92f723e2e94e21bbc"
    sha256 cellar: :any,                 arm64_ventura:  "ec6a07d7e79d18e7dbe72847085c6762214eaa6a0a674024c30a4e3387a09727"
    sha256 cellar: :any,                 arm64_monterey: "cb2cc4ff31d1be18127691bbdaecf5bb9cc78d18b35946c1a0bd754551052fcf"
    sha256 cellar: :any,                 ventura:        "824710365a54cfd551d9a2da565bb29aac287d945f9b3be769925b67534e348e"
    sha256 cellar: :any,                 monterey:       "c5179f73d91befec67431e07836cbe877631fa6624853228ab7376c6c220cfa4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b3d2da13fa6b3bef802775230a00620c2289254bc742c0268804beb98d2a47f3"
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
