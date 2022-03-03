# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT81 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-4.2.2.tgz"
  sha256 "c338afd29259f0093f07f4e99b80705a2d5bb046c7ab32e5938eef29bbb63a6e"
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "f18b044b7c16a197e00665ea5953382a493323f3ddf524113e50f89f0c3d8466"
    sha256 cellar: :any,                 big_sur:       "28398683f02bfee3611598cb8e36b9b5d7093923798bb90ece797daef209bffd"
    sha256 cellar: :any,                 catalina:      "e08d39c2b7dbfcdaf15a1233023f7c46387d386ac89bd909893f4e0ef9befd2d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9435fe82cdbd37f683ccd035a223cf16ef25b2e260626b251b30a4b195994d24"
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
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@8.1"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
