# typed: false
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

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "de2ee51b6023b81f12f17266811fd0c80bda10b78d31f6834414be3e307291e8"
    sha256 cellar: :any,                 arm64_big_sur:  "6faf7b9c14b487af06e765afb79a488aeb150de3d140d8214d97fec97c53914a"
    sha256 cellar: :any,                 monterey:       "05983dc846521989e3c9bc24fe1cd708d803d39ca5b556fdc0a6d101d0719e60"
    sha256 cellar: :any,                 big_sur:        "911f5d23175e797ff455e2ad1887a9e31f5eaab49ef86acd55e6c16b5f4baeb6"
    sha256 cellar: :any,                 catalina:       "b1b6df01d5faa76ca4fdf0acd0b212df535f3a7b5fceddbe000d690c76dc49e2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "acdcdb68aceda05fe41df2c4fb5bfc02f4dd162edaa0d6545d918f9e1e93773e"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/propro@7.1"
  depends_on "shivammathur/extensions/raphf@7.1"

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
