# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT82 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-4.2.4.tgz"
  sha256 "fb1e10c2e5edfb011ff8dc2e473cdbd2bbe0127d1279dfce4d98570555ac6ded"
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "e39ddfc73adce4e37cf4874a72b84b3c6dcebdf4ddc6be186da634e39a41eeaa"
    sha256 cellar: :any,                 arm64_ventura:  "9cd9aabb73e69f7802898ed7fdad8d91a5e6e495914743175340b9d36ae44188"
    sha256 cellar: :any,                 arm64_monterey: "14c746d6b63321657fe4f6c923f25067d06f93e38acd08553b2065a094a2c212"
    sha256 cellar: :any,                 ventura:        "b43245209afc50abf2b4e0649dd539d70ccaefd267fd863c3003a1c2137f272b"
    sha256 cellar: :any,                 monterey:       "1eb5d0932d09a6a49856580e1c7d9884235c750c73378fff7317dae049d91873"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "029e2b1b0acd0cd904ab89a01d78c6b35a538a1dcb1edbf501c12e2cd545d695"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/raphf@8.2"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/raphf@8.2"].opt_include}/php
    ]
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@8.2"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
