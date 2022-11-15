# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT70 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-3.3.0.tgz"
  sha256 "9194524be3997328b6788ef37e37485253e03eadc4bf51abd740358d03d2f536"
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "a8bb86172b8aac75e433d7a83243bdf14cf791478128d78dcc5a716ca6623b4e"
    sha256 cellar: :any,                 arm64_big_sur:  "2a56bdb8494f3e0c55f04e1c611b1058c20412adb7fa6b231b18fa214482df1c"
    sha256 cellar: :any,                 monterey:       "77a3b57b3eb7d6a9d27e01e8083a02865b4b5156d5acdd83a39f0087809f6e49"
    sha256 cellar: :any,                 big_sur:        "be47e03ef3868f2069f2e36a861b5ec4175f26d960f809c4865996b37042672a"
    sha256 cellar: :any,                 catalina:       "c9f1141e93c24cb694538605f77305689e25a851273286e89497a5be4c74d037"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "cddc6387a85567602648ec5b25573eaadfa988e4596539ac9bf20d86b75d9d7f"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/propro@7.0"
  depends_on "shivammathur/extensions/raphf@7.0"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/propro@7.0"].opt_include}/php
      -I#{Formula["shivammathur/extensions/raphf@7.0"].opt_include}/php
    ]
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@7.0"
    inreplace "src/php_http_api.h", "ext/propro", "ext/propro@7.0"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
