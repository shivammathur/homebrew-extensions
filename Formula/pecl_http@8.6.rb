# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT86 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-4.3.1.tgz"
  sha256 "1512dc02fea2356c4df50113e00943b0b7fc99bb22d34d9f624b4662f1dad263"
  revision 2
  head "https://github.com/m6w6/ext-http.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/pecl_http/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_tahoe:   "6921fff668f646f270354f372846d7c0427db132c806a708aaf05e2faeab4127"
    sha256 cellar: :any,                 arm64_sequoia: "d8bc9205bdf3462d0dc5bf11a9ad81babbb5f9108dcf0cdf312fce398601b0e7"
    sha256 cellar: :any,                 arm64_sonoma:  "f8c6267ff4277e75ef8e2859e177af90431d86918599dc49dcaf40089731f921"
    sha256 cellar: :any,                 sonoma:        "c033965f9f7a81be33537105c3ebdd5681d4f8da95c20c72dcd20d9655ecc54e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "7aaedc5aeac9c667179e959ce8621b7956509ba9bbc03e899deb56b30385dd03"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ea4f535593b2c98c54c90055aa82fad7af707844fc30cdd6bd64b3f02c4ca36c"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c@78"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "openssl@3"
  depends_on "shivammathur/extensions/raphf@8.6"
  depends_on "zlib"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{Formula["zlib"].opt_prefix}
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/raphf@8.6"].opt_include}/php
    ]
    # Work around to support `icu4c` 75, which needs C++17.
    ENV.append "CXX", "-std=c++17"
    ENV.libcxx if ENV.compiler == :clang
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@8.6"
    inreplace Dir["src/**/*.{c,h}"].select { |f| File.read(f).include?("ZEND_RESULT_CODE") },
              "ZEND_RESULT_CODE", "zend_result"
    inreplace "src/php_http_filter.c" do |s|
      s.gsub! "PHP_HTTP_FILTER_FUNC(chunked_decode),\n\tPHP_HTTP_FILTER_DTOR(chunked_decode),",
              "PHP_HTTP_FILTER_FUNC(chunked_decode),\n\tNULL,\n\tPHP_HTTP_FILTER_DTOR(chunked_decode),"
      s.gsub! "PHP_HTTP_FILTER_FUNC(chunked_encode),\n\tNULL,\n\t\"http.chunked_encode\"",
              "PHP_HTTP_FILTER_FUNC(chunked_encode),\n\tNULL,\n\tNULL,\n\t\"http.chunked_encode\""
      %w[deflate inflate brotli_encode brotli_decode].each do |filter|
        s.gsub! "PHP_HTTP_FILTER_FUNC(stream),\n\tPHP_HTTP_FILTER_DTOR(stream),\n\t\"http.#{filter}\"",
                "PHP_HTTP_FILTER_FUNC(stream),\n\tNULL,\n\tPHP_HTTP_FILTER_DTOR(stream),\n\t\"http.#{filter}\""
      end
      s.gsub! "static php_stream_filter *http_filter_create(const char *name, zval *params, uint8_t p)",
              "static php_stream_filter *http_filter_create(const char *name, zval *params, bool p)"
      s.gsub! "php_stream_filter_alloc(&PHP_HTTP_FILTER_OP(chunked_decode), b, p)",
              "php_stream_filter_alloc(&PHP_HTTP_FILTER_OP(chunked_decode), b, p, PSFS_SEEKABLE_NEVER)"
      s.gsub! "php_stream_filter_alloc(&PHP_HTTP_FILTER_OP(chunked_encode), NULL, p)",
              "php_stream_filter_alloc(&PHP_HTTP_FILTER_OP(chunked_encode), NULL, p, PSFS_SEEKABLE_NEVER)"
      %w[inflate deflate brotli_encode brotli_decode].each do |filter|
        s.gsub! "php_stream_filter_alloc(&PHP_HTTP_FILTER_OP(#{filter}), b, p)",
                "php_stream_filter_alloc(&PHP_HTTP_FILTER_OP(#{filter}), b, p, PSFS_SEEKABLE_NEVER)"
      end
    end
    inreplace "src/php_http_message_body.c", "standard/php_lcg.h", "random/php_random.h"
    inreplace "src/php_http_misc.c", "standard/php_lcg.h", "random/php_random.h"
    inreplace %w[
      src/php_http_negotiate.c
      src/php_http_header_parser.c
      src/php_http_env.c
      src/php_http_encoding.c
      src/php_http_client_request.c
      src/php_http_env_request.c
      src/php_http_params.c
      src/php_http_header.c
      src/php_http_message_parser.c
      src/php_http_url.c
      src/php_http_env_response.c
      src/php_http_message.c
      src/php_http_querystring.c
    ], "zval_dtor", "zval_ptr_dtor_nogc"
    inreplace "src/php_http_client_curl_user.c",
              "ctx->closure.internal_function.arg_info = (zend_internal_arg_info *) &ai_user_handler[1];",
              "ctx->closure.internal_function.arg_info = (zend_arg_info *) &ai_user_handler[1];"
    inreplace %w[
      src/php_http_client.c
      src/php_http_cookie.c
      src/php_http_encoding.c
      src/php_http_header_parser.c
      src/php_http_message.c
      src/php_http_message_body.c
      src/php_http_message_parser.c
      src/php_http_object.c
    ], "XtOffsetOf", "offsetof"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
