# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zmq Extension
class ZmqAT73 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_ventura:  "f7cc2511556d25d5a65ea7d5bc734313297e38e6ea3ff77bde23af5e352a15bc"
    sha256 cellar: :any,                 arm64_monterey: "96475a12db69ad9a550f1f6c81634419a1efdc6736817649bd7f4dac7b6580d3"
    sha256                               arm64_big_sur:  "cfb413e94ee3625e48d2134e0d84e2317294a354610f1f72cdcd7fd779604be2"
    sha256 cellar: :any,                 ventura:        "bf17a3c1cebad4e068ec08fd45fd355ed2c220a6bc34423c4595028fd9fb905e"
    sha256                               big_sur:        "13eba1ba47468cec0e66cc060668912fbaa8e4260d82ddffa40e2edc06aec9fd"
    sha256                               catalina:       "2889c4cd792a3f60c55a601abc71fa2c77ebc676a36977e402e88763970385d5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9be48497ba440d637fbe6b4065fbc1d8ebb006759a81bca5fa6c8b830b53134a"
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
