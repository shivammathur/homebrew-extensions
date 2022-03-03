# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT72 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-3.2.5.tgz"
  sha256 "38f9345cee2e60b4919af73a6a291e1d3b90543c61edc9def6bd783f3b100728"
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "5b48e06fc1c9a15719a0f6f3195f2e8faaccc724d0b077e2c7336df7dbba59ba"
    sha256 cellar: :any,                 big_sur:       "a291809963f4269d4d41b2a1285ef30e56262689e309180cbe7926ec1e05b781"
    sha256 cellar: :any,                 catalina:      "b8b3887df1764210b6bbb9475bf591a42c2610c0121d876a6621dba474f7c865"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d9cb123712d8dd5467098410d222674e4c14395c4efee52638e0e6bf6499eaaa"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/propro@7.2"
  depends_on "shivammathur/extensions/raphf@7.2"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/propro@7.2"].opt_include}/php
      -I#{Formula["shivammathur/extensions/raphf@7.2"].opt_include}/php
    ]
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@7.2"
    inreplace "src/php_http_api.h", "ext/propro", "ext/propro@7.2"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
