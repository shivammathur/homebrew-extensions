# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT82 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-4.2.3.tgz"
  sha256 "fa2ab558fc8f0928a10f35c0f566f7c4a1d32e727bd3a96579e4c28482ee9d6a"
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "05d428812573e6a61ad5e7033faa54d19d81e720f7bbfff18dacc8e0cb8e5bed"
    sha256 cellar: :any,                 arm64_big_sur:  "8962eb172eeda2cbf1a108564ef645764342add4d42192cf0e99a2d2131ebcae"
    sha256 cellar: :any,                 monterey:       "73f3937a7d6197a5d62230e2fe3544ce9a34a15894b4b79222e7a72d7008be92"
    sha256 cellar: :any,                 big_sur:        "7bc93c99713e2385b84943271f88dc623615d1570d3a93e1da93c2d8375062c2"
    sha256 cellar: :any,                 catalina:       "cc8f5a76282139128c16ff78be191f7e1eac4adda8e303d5bceee37d4f228499"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d807264bae1bf4aaba6461941a8986ce269271f8f5278f28723407350a4c2863"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/raphf@8.2"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/raphf@8.2"].opt_include}/php
    ]
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@8.2"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
