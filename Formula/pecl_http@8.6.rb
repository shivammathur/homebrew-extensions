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
  revision 6
  head "https://github.com/m6w6/ext-http.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/pecl_http/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "c06e0ca3a074aac10a54649277925356751b273df646fac6c96ca3dea0a6c1db"
    sha256 cellar: :any, arm64_tahoe:       "f3eca577698b0c73039202086f8fc8387fb2bf5df1fe349c4bb3d7c03110b051"
    sha256 cellar: :any, arm64_sequoia:     "80c3a465c7fc8e385e9ca1d58f115e43635fa9bc479200782e1ae4b838e94184"
    sha256 cellar: :any, arm64_linux:       "0762ed0f0e13a710d7f1308a884e58ee897f9a943991b73da4b94f706ea57a42"
    sha256 cellar: :any, x86_64_linux:      "ace68429f006420c2394e7a4182886e066c81af75e9001d60d4f361fd9f2ff8c"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c@78"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "openssl@4"
  depends_on "shivammathur/extensions/raphf@8.6"
  depends_on "zlib"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Utils::Path.formula_opt_prefix("icu4c")}
      --with-http-zlib-dir=#{Utils::Path.formula_opt_prefix("zlib")}
    ]
    extra_includes = %W[
      -I#{Utils::Path.formula_opt_include("shivammathur/extensions/raphf@8.6")}/php
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
              "php_stream_filter_alloc(&PHP_HTTP_FILTER_OP(chunked_decode), b, p, " \
              "PSFS_SEEKABLE_NEVER, PSFS_SEEKABLE_NEVER)"
      s.gsub! "php_stream_filter_alloc(&PHP_HTTP_FILTER_OP(chunked_encode), NULL, p)",
              "php_stream_filter_alloc(&PHP_HTTP_FILTER_OP(chunked_encode), NULL, p, " \
              "PSFS_SEEKABLE_NEVER, PSFS_SEEKABLE_NEVER)"
      %w[inflate deflate brotli_encode brotli_decode].each do |filter|
        s.gsub! "php_stream_filter_alloc(&PHP_HTTP_FILTER_OP(#{filter}), b, p)",
                "php_stream_filter_alloc(&PHP_HTTP_FILTER_OP(#{filter}), b, p, " \
                "PSFS_SEEKABLE_NEVER, PSFS_SEEKABLE_NEVER)"
      end
    end
    inreplace "src/php_http_message.c", "_php_stream_write", "php_stream_write"
    inreplace "src/php_http_message_body.c", "standard/php_lcg.h", "random/php_random.h"
    inreplace "src/php_http_message_body.c", "_php_stream_read", "php_stream_read"
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
