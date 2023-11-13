# typed: true
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
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_ventura:  "006353eaf678219dee08ff82b4fb34b055e260c5f756b5e55586a8ee042d264c"
    sha256 cellar: :any,                 arm64_monterey: "aceb395ba2e1397f01692c3a67393e153faecccf3a0b2775d642dafeb5ddb765"
    sha256 cellar: :any,                 arm64_big_sur:  "e4fda64467065d262f5f99dae6c60e240e7882d39381d05c310194d0291c340c"
    sha256 cellar: :any,                 ventura:        "68ac0b5b8486619216f6379d8a30a7589d3a0a59317070c320229bbdf0c07926"
    sha256 cellar: :any,                 monterey:       "8604142ceab13b5643c07030d235e4c84a7dbba49e1acab0583edc9d6ead9874"
    sha256 cellar: :any,                 big_sur:        "fa562509ed30dab8bca8e81299c62cfa6198a354dfc08f88db09e9d6db563dad"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2665cf9473720322ea722026441f4e61cef735f697d6bb29607b13454a06e63e"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/propro@7.2"
  depends_on "shivammathur/extensions/raphf@7.2"

  priority "30"

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
