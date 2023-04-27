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
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "bc1dbe26d575fac5d554d82993f6578b27c48bcfd61e5d664e4f5a24f2c90e1b"
    sha256 cellar: :any,                 arm64_big_sur:  "0187923c40c401455d496f96e4884e779117570ebcc1fc7aeee0e4c4473511c2"
    sha256 cellar: :any,                 ventura:        "dc88f71b645433b50214b079e6b5705f7c8f62b1dc2b9613f56e4d06627564d2"
    sha256 cellar: :any,                 monterey:       "22f0b3a6d95350c0f1e3dddcdbecc2915a0bd595d755f9a81b5955799fa339ab"
    sha256 cellar: :any,                 big_sur:        "5c7570110393381efd4ea868edec7625536131da48c7fe70f48c6e0ecec4b084"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e25963364410ce3397caf7516e99bbf325c959102878e517e80fd6f773bc1025"
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
