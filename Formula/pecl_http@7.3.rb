# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT73 < AbstractPhpExtension
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
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "9ecf771e3b26399825a9b500dc2671e902121fb3f7914475cd94bf621a002a01"
    sha256 cellar: :any,                 arm64_big_sur:  "318fa14e9309d9d2f04676ba0a0246241c2ecc09d7f3171c4a03e38a342b53af"
    sha256 cellar: :any,                 ventura:        "f6888d9fa81e4ddf20dd462e901f276edb672ba2dcd0589dc0010213e01a86fa"
    sha256 cellar: :any,                 monterey:       "f8556df335a8a04b62d00d0b04f5f08a7343c2af1b9376d43d7fcd479e2a98da"
    sha256 cellar: :any,                 big_sur:        "d8587191fac7e58024ec580c8d2901eea5915b56f5a1ea7df23a90276e2e22f0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b954ef084823b4756ff5588de154eea975e799f7b1c470b573b6b6c8aee95761"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/propro@7.3"
  depends_on "shivammathur/extensions/raphf@7.3"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/propro@7.3"].opt_include}/php
      -I#{Formula["shivammathur/extensions/raphf@7.3"].opt_include}/php
    ]
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@7.3"
    inreplace "src/php_http_api.h", "ext/propro", "ext/propro@7.3"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
