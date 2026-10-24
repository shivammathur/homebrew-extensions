# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT74 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "9a237ed06544cf6611634151c5be5b04bafae003db2328595ba799445e41ace7"
    sha256 cellar: :any, arm64_tahoe:       "0da6cda6ecd3376f98b42adf3c14f1ecbfb75e86b93e8a8e03a53962fe46a176"
    sha256 cellar: :any, arm64_sequoia:     "ed8e8a1be75f65eb19c2994d68eac80aaffcb708cb82a3d26c87469c2d292b4c"
    sha256 cellar: :any, arm64_linux:       "44a22a6b39008d325cdfcb71b44d1aab85a332a82927cdb51cf8e6b1c4a170d9"
    sha256 cellar: :any, x86_64_linux:      "c57730cd38ec882463c056a4e7e0199aa59751c7a0f9a3fb38159e660f880fa0"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c@78"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "openssl@4"
  depends_on "shivammathur/extensions/propro@7.4"
  depends_on "shivammathur/extensions/raphf@7.4"
  depends_on "zlib"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Utils::Path.formula_opt_prefix("icu4c")}
      --with-http-zlib-dir=#{Utils::Path.formula_opt_prefix("zlib")}
    ]
    extra_includes = %W[
      -I#{Utils::Path.formula_opt_include("shivammathur/extensions/propro@7.4")}/php
      -I#{Utils::Path.formula_opt_include("shivammathur/extensions/raphf@7.4")}/php
    ]
    # Work around to support `icu4c` 75, which needs C++17.
    ENV.append "CXX", "-std=c++17"
    ENV.libcxx if ENV.compiler == :clang
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@7.4"
    inreplace "src/php_http_api.h", "ext/propro", "ext/propro@7.4"
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
