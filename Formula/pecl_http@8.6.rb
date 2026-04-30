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
    sha256 cellar: :any,                 arm64_tahoe:   "631f0ff3fd493c80c19a250e281590b119d94e5ddb2547ec0b12967aab896545"
    sha256 cellar: :any,                 arm64_sequoia: "b017910a811b0c26fb745baf9e6f24ecff096cdc9180ba5938d2e329c41241b9"
    sha256 cellar: :any,                 arm64_sonoma:  "b685c59271ef2d11c78014dac7c55eb5549162ff6fed48f9a831f55162a8229f"
    sha256 cellar: :any,                 sonoma:        "01fe5bae1a33baeee014ad1dba3b84c757bb85854ed8e918691b4ba98c0dde51"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "dd40445feba3bd0577a100b82423df90b4ca3e1f481875de42af2c816c6ccd45"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "aa7993aca22baab667afaeca22e7328a27dfe84581220af1c7935c732821f38f"
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
    Dir["src/**/*.{c,h}"].each do |f|
      contents = File.read(f)
      next if contents.exclude?("XtOffsetOf") && contents.exclude?("zval_dtor")

      needs_stddef = contents.include?("XtOffsetOf")

      inreplace f do |s|
        s.gsub! "XtOffsetOf", "offsetof" if needs_stddef
        s.gsub! "zval_dtor", "zval_ptr_dtor_nogc" if contents.include?("zval_dtor")
        s.sub!(/\A/, "#include <stddef.h>\n") if needs_stddef
      end
    end
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
