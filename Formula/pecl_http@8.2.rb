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
    rebuild 3
    sha256 cellar: :any,                 arm64_monterey: "befccbf1cc7dbd82c6552fe9734bf52a010cdc05755c6ad2c83b0d42079ca71a"
    sha256 cellar: :any,                 arm64_big_sur:  "b18bfd3c93a55d0330acef30cdcc9551c197c01f1d6497ec37e4d7ad19fdd7af"
    sha256 cellar: :any,                 monterey:       "0cf39a6084b81ce5a593e085c6a83349a29e91250da46f232776fa5cf20762a3"
    sha256 cellar: :any,                 big_sur:        "b1344cc2b8c8c217f9cd2f4aba3ecf58f3db458a452229acd677083a03559dbe"
    sha256 cellar: :any,                 catalina:       "2ab8cfcaf77db08e97703accd7caaff6811457698678ea0ea6f5cde09e5c4747"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fc663c7995eae83686193466dbef4c164200c7616898878cff0d50e84f05205c"
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
