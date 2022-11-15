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

  priority "30"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "c019a4b3ccfe4afc08b1e72233467810287b69b62b2401780c88e7c0096b6026"
    sha256 cellar: :any,                 arm64_big_sur:  "30ff23dad2486d17e1e9c405943bac533aad8c51b02b26da738a65b92c80bc12"
    sha256 cellar: :any,                 monterey:       "cc4e47d4b2efed703e9f824dd65a14314ede31d7a7d3b08c77515fb20443adf1"
    sha256 cellar: :any,                 big_sur:        "3e0dee10ee62a54e4d2424dfc165bd1804e8430022fd9c4b09f1edfd062a0d7f"
    sha256 cellar: :any,                 catalina:       "a34b87ea58ac2052d7e04180cb060b59e88b7f2c18b7ddeafdd6ad3e596b1f67"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ad159f1be66ce5c762c2d76f392da38e030056a512e8c359bc8cb55e1b66dae2"
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
