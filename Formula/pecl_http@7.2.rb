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

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "1e9f0a3713e4e3b8a6be829460aa0757827f2284cb15bb8356c6116820b40a7a"
    sha256 cellar: :any,                 arm64_big_sur:  "caec9583c340cf8c8b708a52f6a7f135c24380ddb13b0bc65ee050b1f963c4d1"
    sha256 cellar: :any,                 monterey:       "9bfbef6815eea9766c15ee3d834d771aef9fd3bf0634d28165446bbefb84884f"
    sha256 cellar: :any,                 big_sur:        "1ffa6346c545d93c22923953ff4f1795857420c8144e93aca1e21e111a04083d"
    sha256 cellar: :any,                 catalina:       "3c8a4ed4499f9aaebf08e8066715e12cb6e2b261ef1ecccf9e6af3a54a052cd0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "70574cf2f1f8fbc45dae548115e2047b6d974d73ccd3f57a08f944caf6f793a8"
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
