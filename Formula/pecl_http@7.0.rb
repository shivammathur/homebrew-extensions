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
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "2cbf3ccc2313fb3f0d3bee5997034d498093f299a81f9b6eb650e77345a93748"
    sha256 cellar: :any,                 arm64_big_sur:  "d6e4b2fa4ecd603d2b5abe26f0c51cfa0ec351d71825157d3471e8bd11f23286"
    sha256 cellar: :any,                 monterey:       "d1d61d234cb4cc2e634ebec663afe3ae59bad096f238bc3b849dbd44aa8f6236"
    sha256 cellar: :any,                 big_sur:        "499374395545d5aea819da43d72c4f308ecd25c0d31962aa377d4f8fa3b18152"
    sha256 cellar: :any,                 catalina:       "5369bdb1163768a913f9050a678cd19b7583143932c64158fea2eced9035175c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b7fde52971ffa3eb482211e371e25caae31f53ddf53031099ee9ce4f30e00b57"
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
