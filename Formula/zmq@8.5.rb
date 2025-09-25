# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zmq Extension
class ZmqAT85 < AbstractPhpExtension
  init
  desc "Zmq PHP extension"
  homepage "https://github.com/zeromq/php-zmq"
  url "https://github.com/zeromq/php-zmq/archive/43464c42a6a47efdf8b7cab03c62f1622fb5d3c6.tar.gz"
  sha256 "cbf1d005cea35b9215e2830a0e673b2edd8b526203f731de7a7bf8f590a60298"
  version "1.1.3"
  revision 1
  head "https://github.com/zeromq/php-zmq.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "0458258131323063f21488488bb7765966c1b3c4fc364dce2144179589d5ad9c"
    sha256 cellar: :any,                 arm64_sequoia: "38723fed01c23290b5ec1877764acc0358ac717a39fd453c9454097420846c69"
    sha256 cellar: :any,                 arm64_sonoma:  "296adcedf03e72b63b31f9d1950d9558d1343b493e03d65d18bc4872f1cb0b9c"
    sha256 cellar: :any,                 sonoma:        "408ff9d20bdb72a3a85930f338da7c96ec7655139ca0f2a373bc3eab04ef7c4f"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "b929a8d47eaf7288c13bc82cc44c7cdcb291b498ab1a7c9a93cd34a3c3a2c2af"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8f6f1fb1e23f897c2d93b7aaf4072a576a12aa5c401c0474666a7713c8a565e7"
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
    inreplace "zmq.c", "zend_exception_get_default()", "zend_ce_exception"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
