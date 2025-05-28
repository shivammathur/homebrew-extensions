# typed: true
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
    rebuild 7
    sha256 cellar: :any,                 arm64_sequoia:  "6329b844d6401e6e6c3c8348f8d18d24eac3dc40cf52b59146fb978fd069b5c7"
    sha256 cellar: :any,                 arm64_sonoma:   "8806ee5bc15c40b34a16620e05a5f926cc96f0dbeb49f786cc3d41a700d9c5ff"
    sha256 cellar: :any,                 arm64_ventura:  "79d2306011ef0d7b58bdc2f085d9159eaf7eb3cbaaf9e9e2f08d849ef1458e48"
    sha256 cellar: :any,                 arm64_monterey: "6dc0401837a1f184642179ae68dff8d93866f26b7e496e89c46170ec0b3c50de"
    sha256 cellar: :any,                 ventura:        "ac4974fa45e7d17153e85d347acff5087dca09864536a9033b2c986d5b592af4"
    sha256 cellar: :any,                 monterey:       "544183660d39b6e1ab6f0214f5617f76177a6b4c1e617542b8a08c800f0c9d2d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4cf92937e36994632e96157b81b743176ace174075586b9e559e561b7184cdd0"
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
