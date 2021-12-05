# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT81 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://github.com/m6w6/ext-http/archive/f8fc5308928741fefb62510991b5a31cc27ab432.tar.gz"
  sha256 "4f4084be21db75b50abff9c3fa4a0502c7cd0f16270b72c2fba445967dcb117d"
  version "4.2.1"
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_big_sur: "9590ad2266973785fe9e7cf580cc90d8c54d00764e765d288c797e2b386bd23e"
    sha256 cellar: :any,                 big_sur:       "066066ab44e5fd0aaa9c812ce96e411e79ce5a5c2e15605a8220e23e7d709a94"
    sha256 cellar: :any,                 catalina:      "0573ee9e9916b09b9ab7ed9d2f2e92da86db7fc8000431968da3466847d5e51d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3b65a787cb52e1087f6d35d7a4627d7c0535e590b1cde3e533bbbefac51a410a"
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
