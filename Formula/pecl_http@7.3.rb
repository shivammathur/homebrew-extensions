# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT73 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-3.3.0.tgz"
  sha256 "9194524be3997328b6788ef37e37485253e03eadc4bf51abd740358d03d2f536"
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "753a5a41dbde4056eeeec352929ad0075c7f7aee2a0b60988269e5e9292042dd"
    sha256 cellar: :any,                 arm64_big_sur:  "2e8f6f94297700ac1f56d32264c867900a9d8405294d7b649309646e32b3bea1"
    sha256 cellar: :any,                 monterey:       "8f02f474bc9710f2827d8d8491b836df55a5ad9d2c1c5fff9af5dd4612767b67"
    sha256 cellar: :any,                 big_sur:        "b743862674bbef573e6529f3b02f93f2ab7990bc33c2480168e0299f7d4364e1"
    sha256 cellar: :any,                 catalina:       "317686b8af44800eecf233b22c6f01a5da28327bfb898592a53f35b1d7625e87"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1d685a6f2a11610caf72778a52b60ea02ade4de5892acca5c5a24906d57d712c"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/propro@7.3"
  depends_on "shivammathur/extensions/raphf@7.3"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/propro@7.3"].opt_include}/php
      -I#{Formula["shivammathur/extensions/raphf@7.3"].opt_include}/php
    ]
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@7.3"
    inreplace "src/php_http_api.h", "ext/propro", "ext/propro@7.3"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
