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
    rebuild 3
    sha256 cellar: :any,                 arm64_ventura:  "0c96bbc27b85d4b81bfb79f94c4171f949f1378eab7826aef2393cbd415fe67e"
    sha256 cellar: :any,                 arm64_monterey: "6d2e46636127c829977075c99f965c38b504179461e358422123223be10dc29d"
    sha256 cellar: :any,                 arm64_big_sur:  "837d3edd8923457a2d832dc1e0b987fd8f56cfb80753a1ae5af4ea8fd9cc0aab"
    sha256 cellar: :any,                 ventura:        "3d64c13f528db4118bc3a4913371efee2383e93dcf0d792b31ae4fa63e991ba3"
    sha256 cellar: :any,                 monterey:       "115ae08877a9a8c47d8019284fdba23ae90ac21a62d7031e11f53d1a54955e01"
    sha256 cellar: :any,                 big_sur:        "edc7a8b731cb59df561ca753787239d8764fdbfda55c03d54cad56dc5e1dedce"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ce36979098b893b7bd16cd9a58ffa80ed4cb016118f4f91e13f4c6800623df02"
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
