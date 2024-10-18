# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT84 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-4.2.4.tgz"
  sha256 "fb1e10c2e5edfb011ff8dc2e473cdbd2bbe0127d1279dfce4d98570555ac6ded"
  head "https://github.com/m6w6/ext-http.git", branch: "master"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_sequoia:  "dad3b3ec7927745223d4a47c4f9f080b5df07d5dda84d33e3e26c08fcebf6061"
    sha256 cellar: :any,                 arm64_sonoma:   "33cdbf8f023a211fabf45e82b69aeb1e8d94f578b7f9637f2df8e98e0eaaf1fc"
    sha256 cellar: :any,                 arm64_ventura:  "974501d330a86aa9f036fc78a39349e14f634b544a750b83af459d42e2830ce2"
    sha256 cellar: :any,                 arm64_monterey: "65094a491970cf51c6a2f29e1e4ea1e1a5952840e975bb9f02112adbf30529e3"
    sha256 cellar: :any,                 ventura:        "7586d2882c8a9a609e44f6384d1cd87a65e3a7fd0367dc77ad84836023254d33"
    sha256 cellar: :any,                 monterey:       "987f1a132b4127caacd96e6148b98ead6e52577ba6dd78d344cadcda455d76f0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7c60b92a083becdafa16c1d4d8fc261f6b98dbae20840b17ee41e6467a9362b7"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/raphf@8.4"
  depends_on "zlib"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{Formula["zlib"].opt_prefix}
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/raphf@8.4"].opt_include}/php
    ]
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@8.4"
    inreplace "src/php_http_message_body.c", "standard/php_lcg.h", "random/php_random.h"
    inreplace "src/php_http_misc.c", "standard/php_lcg.h", "random/php_random.h"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
