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
    sha256 cellar: :any,                 arm64_sonoma:   "7ac9c650822d795dc744052d5d401999f22f3a599409a25ca266ae5c904e0fc6"
    sha256 cellar: :any,                 arm64_ventura:  "67d44ce4f10aa6975117f242fd1352baf84e857facd85f1040ee12d325b92c2a"
    sha256 cellar: :any,                 arm64_monterey: "320f2ddfd9c40c82e9b915d1907b5c861ee90a91d69bfa01a63c0f190e6e50a1"
    sha256 cellar: :any,                 ventura:        "d870c2a8ecc080494c9c558ce0afcf6b207ae1b8a7c390094f5404be248af81d"
    sha256 cellar: :any,                 monterey:       "e03552fee7f70a3bccb34f85bb05b2aa4c715fb70c9ebff443617b3b70b35776"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "cee6426da17703b01140e21d7ec19a025bf30e6ba2b79ad84cae7458d1d32a24"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/raphf@8.4"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
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
