# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT71 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-3.3.0.tgz"
  sha256 "9194524be3997328b6788ef37e37485253e03eadc4bf51abd740358d03d2f536"
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "9c7e9db88dee2bb16fdd7a9fb964405ca9b455f39208ca83d39fbfba3fbd1bdc"
    sha256 cellar: :any,                 arm64_big_sur:  "d7fe5fb1cb6bb969d837c9735e8fc242fa67d023c68f3c59494a662ea05194e0"
    sha256 cellar: :any,                 monterey:       "5f330e5fe7219960c57eb81b17f8ce192625246125fef74cebe66ef7730893e7"
    sha256 cellar: :any,                 big_sur:        "15fd7f1ddd4b9b738e09fc84908d66ee5955383a84fc62e4f95b6653fcf8106d"
    sha256 cellar: :any,                 catalina:       "cd9e966b6e4147ba47dd24556c8eb736dc4cf163aa48c3fa24f392a7f2ebdd46"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "407496be6891332065aab9f298589b8e53f2e95d81e4ea7e388013801adc48b4"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/propro@7.1"
  depends_on "shivammathur/extensions/raphf@7.1"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/propro@7.1"].opt_include}/php
      -I#{Formula["shivammathur/extensions/raphf@7.1"].opt_include}/php
    ]
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@7.1"
    inreplace "src/php_http_api.h", "ext/propro", "ext/propro@7.1"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
