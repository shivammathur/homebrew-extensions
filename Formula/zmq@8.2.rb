# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zmq Extension
class ZmqAT82 < AbstractPhpExtension
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
    rebuild 5
    sha256 cellar: :any,                 arm64_ventura:  "2aea2b376821cb11c61959dcd58782d1fe473157b3548169f82e6084848bd5d3"
    sha256 cellar: :any,                 arm64_monterey: "82c5d4a440082933452c760be75ea3b773e433288290d20bb12250fb74b556df"
    sha256 cellar: :any,                 arm64_big_sur:  "0e3690ac7c07d13d022ee7eb42a4454a3ed4ebe0228f267c8965a03e72f20c93"
    sha256 cellar: :any,                 ventura:        "3c9d78612afbb83c21de73e1e428273356e69407fcad67135a5fdd74e4ff4af8"
    sha256 cellar: :any,                 monterey:       "ef5522efaf949a2bd20dd5f6e2c5930eafc98c57cb61a2a6ba3abf5d847c2171"
    sha256 cellar: :any,                 big_sur:        "4edaf3740c17b841ad1eaa17450929e819e38855f9b18b70d70812b905b23f16"
    sha256 cellar: :any,                 catalina:       "e531d2b3a0396ec9ff52f5488463b4e4e1827ca58976e2ea191de8cd589aacf5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "250d17b6cb702d0b71babc2fee14889b87e69ead2da8a9ebc9b92e905c7199a9"
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
