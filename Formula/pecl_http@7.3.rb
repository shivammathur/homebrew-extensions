# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT73 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "a322a57854a4cfebd89b705067d9784111a48b42f8e3b5c4ee87bb3b01faddf4"
    sha256 cellar: :any, arm64_sequoia:     "5907dae546df5463cf94a65106cf95b47312cb6900290cb8a7cf4e961d44e747"
    sha256 cellar: :any, arm64_linux:       "27d8524cddce389c0eab0d8de68f9a5e1fb029f1b0ca32ecfedb46cbe003ad86"
    sha256 cellar: :any, x86_64_linux:      "10fddb1244f0256bcc2388293d999c1d316bcfa38691ea79c2db5472c4dfc34a"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c@78"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "openssl@4"
  depends_on "shivammathur/extensions/propro@7.3"
  depends_on "shivammathur/extensions/raphf@7.3"
  depends_on "zlib"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Utils::Path.formula_opt_prefix("icu4c")}
      --with-http-zlib-dir=#{Utils::Path.formula_opt_prefix("zlib")}
    ]
    extra_includes = %W[
      -I#{Utils::Path.formula_opt_include("shivammathur/extensions/propro@7.3")}/php
      -I#{Utils::Path.formula_opt_include("shivammathur/extensions/raphf@7.3")}/php
    ]
    # Work around to support `icu4c` 75, which needs C++17.
    ENV.append "CXX", "-std=c++17"
    ENV.libcxx if ENV.compiler == :clang
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@7.3"
    inreplace "src/php_http_api.h", "ext/propro", "ext/propro@7.3"
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
