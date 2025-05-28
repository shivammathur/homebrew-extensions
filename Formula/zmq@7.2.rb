# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zmq Extension
class ZmqAT72 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia:  "9169dc6993b2db385915aa2ba6e486e0505a0cd6ce1f937d5c07c255c396d4bc"
    sha256 cellar: :any,                 arm64_sonoma:   "71f1cb5539309d9c322410fdcdf3639e601b2ae0ac48a16c32c673b828bcbfa3"
    sha256 cellar: :any,                 arm64_ventura:  "a0f466d394c51415a0bda9fe333e197c9112848d531109107eeaa7a2287156a8"
    sha256 cellar: :any,                 arm64_monterey: "10fe7451452313b9dca9e1927048702bb0ebf81b40a2c88bd8d76f5ec58686b5"
    sha256 cellar: :any,                 ventura:        "f0cb07395dd82a22192525ddd1a4c4983975668371aeb1fe62ec1cb2af211bbd"
    sha256 cellar: :any,                 monterey:       "72243191a0b4bbadb1d720eff3c746c92c3804d58db6ea45d8da19a5270d9439"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e7937f7d75a82e980404b9d9934312046622a3067a97c17ccfd2f96c91f39ac4"
  end

  depends_on "zeromq"

  on_macos do
    depends_on "czmq"
  end

  def install
    ENV["PKG_CONFIG"] = "#{HOMEBREW_PREFIX}/bin/pkg-config"
    ENV.append "PKG_CONFIG_PATH", "#{Formula["zeromq"].opt_prefix}/lib/pkgconfig"
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
