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
    rebuild 3
    sha256 cellar: :any,                 arm64_ventura:  "e7c0e0fd49d01f8b3dc617e65801056e9e20a736d26c6d7909d95938573828b8"
    sha256 cellar: :any,                 arm64_monterey: "b8301d7abdae094761f3bbc7ef6b02791fc7de838b6c29ee2b3584adf5682987"
    sha256 cellar: :any,                 arm64_big_sur:  "bf74378ae92f5bfad65ea836d17b11b5c7dd0ed241f8b8d443e089eaba6eefe3"
    sha256 cellar: :any,                 ventura:        "a3a695e70e975cf6b433c1c6ed661eac3cdb4b518159dc716fd1bfeea12e55f5"
    sha256 cellar: :any,                 monterey:       "dcfd982debefc10aae2b7418f13cd1974cfcf5d34a43c3ec6831d8f5865d3ec3"
    sha256 cellar: :any,                 big_sur:        "22f87eb848cb37cadb2ca7ef9bd6b24504d83ce7acf57034342cf6a9beded6a1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d2c3e1108bbf0221b31a53909caa7c9faa3de86532b1d044bce764170ba9b33b"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/propro@7.1"
  depends_on "shivammathur/extensions/raphf@7.1"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
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
