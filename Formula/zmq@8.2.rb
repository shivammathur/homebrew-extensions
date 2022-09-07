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
    rebuild 4
    sha256 cellar: :any,                 arm64_monterey: "c7838557b10379a954e9db6953ab5bb94c2d1cdf3ac49ae8d6efec2aadd24726"
    sha256 cellar: :any,                 arm64_big_sur:  "8e8cfee72a706ae84b85204cac34bc366362b3148061018b7378e1d6ffbe4eca"
    sha256 cellar: :any,                 monterey:       "4166c16078981ab970f553b6e29bfe08bc32151f6513fce0da624577e4a92b17"
    sha256 cellar: :any,                 big_sur:        "910efd53a0c31c0365dc72fc6a209b0f4559cd5c424969224fa95c68667b049f"
    sha256 cellar: :any,                 catalina:       "2f3d4b710b9b30e9c25dba7d31b11a27562eadea23a7b8d7c5dc55baaa0d63ec"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "dbf515f0d424a2f652ce65da86563038eaf0b69b226d7e7bb989562b00aa39f7"
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
