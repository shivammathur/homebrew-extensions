# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT71 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-3.3.0.tgz"
  sha256 "9194524be3997328b6788ef37e37485253e03eadc4bf51abd740358d03d2f536"
  head "https://github.com/m6w6/ext-http.git", branch: "master"
  license "BSD-2-Clause"
  revision 5

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "e1b5f9cf0ed50ce59d9829c52c6cedaade63a276ff7b4cecc03407dd17dec5e9"
    sha256 cellar: :any, arm64_tahoe:       "9372042301742bb9d330131ac080c85252f01089774dbfa022cce4ea4bb24df3"
    sha256 cellar: :any, arm64_sequoia:     "4a3b5458c34b18a4cf89e3a49de29fb8670b41eb58e26a35191fd41150ff5389"
    sha256 cellar: :any, arm64_linux:       "735f47bfa52cfbb5295e4dffa743805aea9370a542ecf34871db185bb880dd5e"
    sha256 cellar: :any, x86_64_linux:      "aa3350d957c3dedcf856ee1f3f3668b8af5f798aff4b6292239b5a2cd3c917f3"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c@78"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "openssl@4"
  depends_on "shivammathur/extensions/propro@7.1"
  depends_on "shivammathur/extensions/raphf@7.1"
  depends_on "zlib"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Utils::Path.formula_opt_prefix("icu4c")}
      --with-http-zlib-dir=#{Utils::Path.formula_opt_prefix("zlib")}
    ]
    extra_includes = %W[
      -I#{Utils::Path.formula_opt_include("shivammathur/extensions/propro@7.1")}/php
      -I#{Utils::Path.formula_opt_include("shivammathur/extensions/raphf@7.1")}/php
    ]
    # Work around to support `icu4c` 75, which needs C++17.
    ENV.append "CXX", "-std=c++17"
    ENV.libcxx if ENV.compiler == :clang
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@7.1"
    inreplace "src/php_http_api.h", "ext/propro", "ext/propro@7.1"
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
