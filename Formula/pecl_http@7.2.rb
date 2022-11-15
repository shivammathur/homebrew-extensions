# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT72 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-3.3.0.tgz"
  sha256 "9194524be3997328b6788ef37e37485253e03eadc4bf51abd740358d03d2f536"
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"

  priority "30"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "fe9af081c99b8c5c5607a385d9692e94400bf381c8910f6de0b6c5fbd76abb40"
    sha256 cellar: :any,                 arm64_big_sur:  "7c72e28a3550b39cd7b544be5927394f48280729e7a35a9e864e9c266ec299a8"
    sha256 cellar: :any,                 monterey:       "af9e44969db9eda7ec40100c2b8531a0ce8e7247b73710bbc3d00b21ea8ba8e4"
    sha256 cellar: :any,                 big_sur:        "61fc3d0480bf8823a70133f75093cf4553d49a15283cb742564663651234dc3e"
    sha256 cellar: :any,                 catalina:       "f31e169d07a1322aaf3e05f8db4713c5d8568ee2b611dd4ce11925bfa77dce97"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "602619d0392d78b603b37c745ed326b889f7fee851162a0ac6a746e0dc7c99dc"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/propro@7.2"
  depends_on "shivammathur/extensions/raphf@7.2"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/propro@7.2"].opt_include}/php
      -I#{Formula["shivammathur/extensions/raphf@7.2"].opt_include}/php
    ]
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@7.2"
    inreplace "src/php_http_api.h", "ext/propro", "ext/propro@7.2"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
