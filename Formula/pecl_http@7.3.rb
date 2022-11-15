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

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "06eb8283a56dad044eb0e2665fff0cccee18bc3f0962007584a8fc621fe2e06f"
    sha256 cellar: :any,                 arm64_big_sur:  "0abde3dbaca154c1b2854ed5740b96afb97f486e551ff3153861ca95213e2b3c"
    sha256 cellar: :any,                 monterey:       "6399e11bf8a6c7c5b89429bc63528b2b5eab7a9f5e98c5ecc8ae1421fb24e919"
    sha256 cellar: :any,                 big_sur:        "3d94654bd4d14623b4b6032983d10074200b410ffba96131acd57e0324c70617"
    sha256 cellar: :any,                 catalina:       "9b8e80c31cdd1f2823532bccec6cfffc70d2f11092ed9c4b12338442f417d555"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2a9c9512c7976f4273d5e2740820f2463429eb40380dd8509f219dbc21a3b933"
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
