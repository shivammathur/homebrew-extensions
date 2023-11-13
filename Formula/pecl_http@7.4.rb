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
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_ventura:  "fe493023d3d81f8cc110c2e58f72b2275e86c1ea614b44fee7283e1e11bb5fb6"
    sha256 cellar: :any,                 arm64_monterey: "53346f0f41edf9466d3075bb434dd32ac5372c5c28f96f8c2161520b0d6ad0df"
    sha256 cellar: :any,                 arm64_big_sur:  "63121417f92d8d985ca50aed82b4a86679b9c347bbc20fb0371e459752037294"
    sha256 cellar: :any,                 ventura:        "bf7b07e8e1b455ff829116c20053a549cbcbd54d5a7e979a6b1e79c3a9f45324"
    sha256 cellar: :any,                 monterey:       "6d89abacb71bc52dd56995fca1687ec52f63f09307da1a85d20bb81404fd04bb"
    sha256 cellar: :any,                 big_sur:        "032c2cd27c9fb75e753fb870c8a0c127f26ba7acff4416dd0ee0441949668db5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "58ee6230f05e47f24786d854b3b421886b930fb43875ae658faffdfd937382fc"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/propro@7.4"
  depends_on "shivammathur/extensions/raphf@7.4"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/propro@7.4"].opt_include}/php
      -I#{Formula["shivammathur/extensions/raphf@7.4"].opt_include}/php
    ]
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@7.4"
    inreplace "src/php_http_api.h", "ext/propro", "ext/propro@7.4"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
