# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT81 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-4.2.3.tgz"
  sha256 "fa2ab558fc8f0928a10f35c0f566f7c4a1d32e727bd3a96579e4c28482ee9d6a"
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "045bdb37896526d1eaf08dd2c1ae1ce5485a89cc30d0eb7a752cf09a7fbd90ac"
    sha256 cellar: :any,                 arm64_big_sur:  "871d7670f752b410d8e83502fcf5bd24dcb326f9ffbac715d063c9c586b577b7"
    sha256 cellar: :any,                 monterey:       "4e43346b775799f8fad47c5db2780719f3813db5533ca0a3685ffbc01706522e"
    sha256 cellar: :any,                 big_sur:        "0f1a14668c55a466b6cefa604e13289b2715cca0ba35920ea1d4e0a0e976451b"
    sha256 cellar: :any,                 catalina:       "3dfed405b352fdec830e0c22feae1df6aa055f2828a373d267366c945579182e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c83768a325b0a6daffe260001bbabcc64ef46078773006dd54df0f2ec93db07f"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/raphf@8.1"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/raphf@8.1"].opt_include}/php
    ]
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@8.1"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
