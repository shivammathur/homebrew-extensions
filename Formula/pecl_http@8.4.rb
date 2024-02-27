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
    rebuild 2
    sha256 cellar: :any,                 arm64_sonoma:   "db8535092d8ce2f27afa1a184333cb16f87527f88d4fa914095c5d4a63d326c8"
    sha256 cellar: :any,                 arm64_ventura:  "ae0c9718c4799ff897e876e0f1ceac3cbab3656407d30249f75a4d2e7c8aeb13"
    sha256 cellar: :any,                 arm64_monterey: "1af6c5f2e0bc94694e4b6a29e1ef80e58d27207ec5b031e3d8dde272296db0e3"
    sha256 cellar: :any,                 ventura:        "ea49129479d4b6420aaab4811cb05c764ada48918a8aabf0565bb9746f14a5b0"
    sha256 cellar: :any,                 monterey:       "200dca50748513b2d537d7d438f3eeea2e8fffa639f2e3d2fca5f16bfd36ea0c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "670b962be6487b0d00381da8cde15e2e6c1835a0df8bb4eac19fd02d946bac23"
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
