# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT71 < AbstractPhp71Extension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-3.2.4.tgz"
  sha256 "37354ff7680b9b9839da8b908fff88227af7f6746c2611c873493af41d54f033"
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 arm64_big_sur: "d9784622ae26bbba025858beb6507cbe7e05cfb3b0d9be5bd931656b8ac783d8"
    sha256 big_sur:       "5dda0f9f4f22ae76ad23fefbaf1efa311d241a8ff26583a54c5d206567065119"
    sha256 catalina:      "ebdb5de6cec9a7623cb254c478053a9db6e163427e7f12ac186c9aa3558e0d17"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/propro@7.1"
  depends_on "shivammathur/extensions/raphf@7.1"

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
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end

  def module_name
    "http"
  end
end
