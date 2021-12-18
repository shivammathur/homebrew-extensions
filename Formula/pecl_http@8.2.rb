# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT82 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://github.com/m6w6/ext-http/archive/efddbd955ca4706f06c461692a561d7d9431adb9.tar.gz"
  sha256 "6f6add7287c4397e92cb8432ef6ed1f680ac39aa1e5caf0cd703987b67056ad6"
  version "4.2.1"
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_big_sur: "31800f99f911d06fabeeaec2f51ff3aced7780a6a9b0b5d8428f8c183dee5444"
    sha256 cellar: :any,                 big_sur:       "35ec6dbba97b1bef2dc51905c5f44734adb9709a4deabc42662807ce0289c804"
    sha256 cellar: :any,                 catalina:      "17466261f5c6c8551b9e767e10e535d0140ee9dab8177f00e100951c9405d734"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2ba12ff60333dd972ae9e45b9a18e047a64c83410514c43e2f49876f1ca7030a"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/raphf@8.2"

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
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@8.2"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
