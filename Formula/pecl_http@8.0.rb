# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT80 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-4.1.0.tgz"
  sha256 "f8b3a0827c4c8c97ef00d51d09c63fa4203f895bd737f954062c16bae3b8ab1e"
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256                               arm64_big_sur: "09a2e255b44ad9427767527cdd3fa219427fd8eee9081bd6cdf7efa8f4675978"
    sha256                               big_sur:       "e0e36aa7b3342df40ef7afac5c5942d3b990c3ccc6bae09a81b2d81fdefe8398"
    sha256                               catalina:      "610ef4fa8eda7829283bfa0ec703e365d43fafa66c6a7eada43d11e18d0f232e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "54ef31744f6adf83d88ecd476d32d3b6717381ad3e2c9b1212b5eb5aac1dda74"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/raphf@8.0"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/raphf@8.0"].opt_include}/php
    ]
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@8.0"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
