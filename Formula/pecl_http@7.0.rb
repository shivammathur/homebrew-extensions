# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT70 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-3.3.0.tgz"
  sha256 "9194524be3997328b6788ef37e37485253e03eadc4bf51abd740358d03d2f536"
  head "https://github.com/m6w6/ext-http.git", branch: "master"
  license "BSD-2-Clause"
  revision 4

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "6650c5b1346fac3effcb7081319a15fbe0d0f7fd1102f354b51af4d9a568f5bf"
    sha256 cellar: :any, arm64_sequoia:     "64817c2e2512b9e4364e719c03c3cb331d8a350886dbd49207efd2ac069bfb9e"
    sha256 cellar: :any, arm64_linux:       "035c07597ea5e280f8d364908afc1f0bb3ae42872a6cb81896dd7e7864bde90a"
    sha256 cellar: :any, x86_64_linux:      "92738200a21bf3ff9095aaed68f8c3d5fef5ba681efd946a57304936320bb4fa"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c@78"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "openssl@4"
  depends_on "shivammathur/extensions/propro@7.0"
  depends_on "shivammathur/extensions/raphf@7.0"
  depends_on "zlib"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Utils::Path.formula_opt_prefix("icu4c")}
      --with-http-zlib-dir=#{Utils::Path.formula_opt_prefix("zlib")}
    ]
    extra_includes = %W[
      -I#{Utils::Path.formula_opt_include("shivammathur/extensions/propro@7.0")}/php
      -I#{Utils::Path.formula_opt_include("shivammathur/extensions/raphf@7.0")}/php
    ]
    # Work around to support `icu4c` 75, which needs C++17.
    ENV.append "CXX", "-std=c++17"
    ENV.libcxx if ENV.compiler == :clang
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@7.0"
    inreplace "src/php_http_api.h", "ext/propro", "ext/propro@7.0"
    inreplace "src/php_http_client_curl.h", "void *(*init)();",
              "void *(*init)(php_http_client_t *client, void *user_data);"
    inreplace "src/php_http_client_curl_event.c", "php_http_client_curl_event_init(php_http_client_t *client)",
              "php_http_client_curl_event_init(php_http_client_t *client, void *user_data)"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
