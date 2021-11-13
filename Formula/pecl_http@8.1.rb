# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT81 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://github.com/m6w6/ext-http/archive/acd765555fa5ae6444093fba17783af05ae09cd0.tar.gz"
  sha256 "2395f1f2ca22d3ef5e98fd3cef4e4335f032e32a754ea6e9e8bbafc61a4ba72c"
  version "4.2.1"
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "05fecae3eda0110eaabbb61077ecde957a84b5d7eaf7a691308e031199a69522"
    sha256 cellar: :any,                 big_sur:       "b7a6754c0f7a6c0fbf0e39944f67126dcbd6cfea2f71ab3a102407aa6c034da0"
    sha256 cellar: :any,                 catalina:      "458cb163b4c0688e931ed87a4cc1f6f0bb22e6d16091a0ffc055e75137c9f8c5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7382c4749cff97939c31eeb64a73f133b34ec28710c091099e008d1d45d5ac44"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/raphf@8.1"

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
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@8.1"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
