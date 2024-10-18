# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT71 < AbstractPhpExtension
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
    rebuild 4
    sha256 cellar: :any,                 arm64_sequoia:  "f955a05b596fe8d02525c1d9a5b7c3668035a9588922c1e6689fc00fb2c4f857"
    sha256 cellar: :any,                 arm64_sonoma:   "e157c899404185c2dab1941512e0dcab0b6d9e1e0407fb80a8347fbebcc689d1"
    sha256 cellar: :any,                 arm64_ventura:  "24bf0868203e6004cea2309bb3a17771990c32c68fac0d11346138de40449ede"
    sha256 cellar: :any,                 arm64_monterey: "09837c1cc0c61791f909f5addd10c4a9330a68e9258973ffac5268984c466e95"
    sha256 cellar: :any,                 ventura:        "1e7a654eabae6793b4d01678000fbbed5a319b01f5f2ab29950244f6882a9c02"
    sha256 cellar: :any,                 monterey:       "0c8cb699a2a1e294675ea12c9ca108f66d283b1ad35e7d0fc888c0f9749f4edc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7d55ed67c0e9be034430e3f4ddd1423b9d310cb97fab7cc96765ad7b82a95592"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/propro@7.1"
  depends_on "shivammathur/extensions/raphf@7.1"
  depends_on "zlib"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{Formula["zlib"].opt_prefix}
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/propro@7.1"].opt_include}/php
      -I#{Formula["shivammathur/extensions/raphf@7.1"].opt_include}/php
    ]
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@7.1"
    inreplace "src/php_http_api.h", "ext/propro", "ext/propro@7.1"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
