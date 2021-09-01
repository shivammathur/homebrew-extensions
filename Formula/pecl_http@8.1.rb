# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT81 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://github.com/m6w6/ext-http/archive/b9e1564632b6d00d1120ee7c73574759af9e6167.tar.gz"
  sha256 "f0a8c55e9c3ba672173dee49bfef6b5ef873776b1e698b1507d58902bb7da760"
  version "4.1.0"
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_big_sur: "c4c18eb27b25775606d651481b12c35aaf763c1f1979904bffb123c417149a50"
    sha256 cellar: :any,                 big_sur:       "37231c7b0b44b667a7d51eea234c861aaceab7631ca009fc343c6e640661a3c6"
    sha256 cellar: :any,                 catalina:      "fdbfb85ed09f6acaaed4f5993dcedceb7886d9a1f2f048a66c139de183896640"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "98383b71dcc8592abb3738d6edb3a3da1f6a2a6f18552328cdb2f1c8c157504d"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/raphf@8.1"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/raphf@8.1"].opt_include}/php
    ]
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@8.1"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
