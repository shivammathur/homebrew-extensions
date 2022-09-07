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
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "3e08362f59682d00971848bcccbb0151cb2e0cf0274b643d44dc2944d6fa4bf7"
    sha256 cellar: :any,                 arm64_big_sur:  "cd4045dcdf7d11f97713dd574e133db8ee1e55ab51e2ad9cda7d70ea9a9684cd"
    sha256 cellar: :any,                 monterey:       "9dce5b86f31f1756292c10ef4180326f524235adcf21e567d30993dcbff0b13f"
    sha256 cellar: :any,                 big_sur:        "e4877ad9ad1980490f233517683d77d089b3ec98b8e953d879ca235420f34565"
    sha256 cellar: :any,                 catalina:       "21c03280b2080d023e4b52642b495725a198b71425049a30061cc7c94357c5dd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d893816d385f996e078f1e5e4685bea95e0f865f764daacd4f3a6f756a2055b2"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/propro@7.4"
  depends_on "shivammathur/extensions/raphf@7.4"

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
