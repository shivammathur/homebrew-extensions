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
    rebuild 1
    sha256 cellar: :any,                 arm64_sonoma:   "f2bedff9a3c382ee76853b4e97085de27476e882d1d9f5b27bbaf8c8bcad1e95"
    sha256 cellar: :any,                 arm64_ventura:  "2e4e117c75cd7eb3dabb939cfea653a2089da611c22a32e334e700de2e7f45f8"
    sha256 cellar: :any,                 arm64_monterey: "3b6ce12a437fd2f1560c28005da9405ff83b0cb4ccce8dfe10e13fc340a37351"
    sha256 cellar: :any,                 ventura:        "3765c054d81c7973edfdd8c87862c27e76f467de2e4278fe76ef63b953cdd102"
    sha256 cellar: :any,                 monterey:       "e14ea8306132e95f04751f85dbd3e2a02bb7b62bc87918a94f8af9c8eaa7a969"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9396efe4c096a704e2ff62c493fa34953f726ef7a598739001269907ce7a9b61"
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
