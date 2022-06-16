# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT70 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-3.3.0.tgz"
  sha256 "9194524be3997328b6788ef37e37485253e03eadc4bf51abd740358d03d2f536"
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "9d899c5a348d60e8be503943bc38022429a2ae2e692e4a6e42860de0b2089347"
    sha256 cellar: :any,                 big_sur:       "5f20b3d42e0e4793252e23a3440ffc6bbc9b9105bc3a437f76872bdcdef4a942"
    sha256 cellar: :any,                 catalina:      "a32bfac0e2f3dfae7a605850ad6359e0d08aa5a2775bf2529c9d8685a4fd3345"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b8ba7b675690e436f4174ac1fdc73e31e5a974a3160e3cf4168fa0d6758df50d"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/propro@7.0"
  depends_on "shivammathur/extensions/raphf@7.0"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/propro@7.0"].opt_include}/php
      -I#{Formula["shivammathur/extensions/raphf@7.0"].opt_include}/php
    ]
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@7.0"
    inreplace "src/php_http_api.h", "ext/propro", "ext/propro@7.0"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
