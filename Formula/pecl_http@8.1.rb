# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_big_sur: "c503d1050772c7fa45a919c2dbec7cfdf3bf1395f3e15b2fc4a03a350ce90933"
    sha256 cellar: :any,                 big_sur:       "7d4aae6a20c559cd2e28d3004fcc429693190114690378e2bafdc57b33f64a18"
    sha256 cellar: :any,                 catalina:      "98d22e748884ef306e26abef15087dfc5dfdd4724858b3c866f7efa99b2479eb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4cb65ceb81717b41824b5b48548133acdf830870468fabecd1149472785a1247"
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
