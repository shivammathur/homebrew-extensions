# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zmq Extension
class ZmqAT81 < AbstractPhpExtension
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
    rebuild 12
    sha256 cellar: :any,                 arm64_big_sur: "666f25e137e5eccd800ee6d289bffd0dcb1160141cddc7e481e519cfff32cb76"
    sha256 cellar: :any,                 big_sur:       "a47cc51af0aefb59a7a506698917d81e13b1d80ba5bbefe5eba284996a4d10b0"
    sha256 cellar: :any,                 catalina:      "5c0bae57ea448d48965a8419433caa880e83871d5396c897c1db12789feeb72e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d8655e31739e1186418b8300267df448d5983d3d80fe32ac18c9d7aca769597c"
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
