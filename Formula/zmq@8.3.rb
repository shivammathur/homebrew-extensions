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
    sha256 cellar: :any,                 arm64_monterey: "5bef7220f71651fc52326f28e7efe8011812053c414a84c9eb6dc7cc7676e6f6"
    sha256 cellar: :any,                 arm64_big_sur:  "19d4f33b31e85c00f551a73625fa25b835f29e5213a2b7edb7dff9c0083e34b6"
    sha256 cellar: :any,                 monterey:       "a93f5eb15de9bd84ea2e343809bfe9de7e7803b833964e4c036af93892987c18"
    sha256 cellar: :any,                 big_sur:        "e586296fd195989faf8f551d83893b7e3dea017be7162e388095e85dbbb74489"
    sha256 cellar: :any,                 catalina:       "cdbf712e98a2b8b6d9d5e18d8131c0a10db98e1e482cbe179028486dfc7d17b3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "07e247a7330810569bef7bb27d8d186945ae35483888450f58bd1fb7cd751c0a"
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
