# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT74 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-3.3.0.tgz"
  sha256 "9194524be3997328b6788ef37e37485253e03eadc4bf51abd740358d03d2f536"
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "50a453641c657ed82ccd8941dd8f7cceb118b75432b8df55276bfaba66bb2309"
    sha256 cellar: :any,                 arm64_big_sur:  "ccf95e2a424a17d0be0baaa4dc46fc20d7373fab7ea69d3bc88f46146516becd"
    sha256 cellar: :any,                 monterey:       "e8a4f0cf780d0b3112f69a197ae0e66150c49d55c0cb0f3e3280d4e6b9dc27da"
    sha256 cellar: :any,                 big_sur:        "56bf3ca4a54cfe3c53ca34e859a64c3ab317c245c7d1c1ab137bffddf1c28bfc"
    sha256 cellar: :any,                 catalina:       "1cac0a0606c7229800e555d61e1eb58972d726b2c1e7ffe2c1a0659ac1f5316a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a9b8d40bbdb8ebe10d008fcb1cb81be2c6082f0b0fd1bb7bd7b34a3af23c7e6f"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/propro@7.4"
  depends_on "shivammathur/extensions/raphf@7.4"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/propro@7.4"].opt_include}/php
      -I#{Formula["shivammathur/extensions/raphf@7.4"].opt_include}/php
    ]
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@7.4"
    inreplace "src/php_http_api.h", "ext/propro", "ext/propro@7.4"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
