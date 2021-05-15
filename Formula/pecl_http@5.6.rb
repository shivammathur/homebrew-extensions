# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT56 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-2.6.0.tgz"
  sha256 "ddbf3eea3d1c7004a7dd83b5864aee5f87b1b6032bc281c08ccc62f83b9931ed"
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "913af193375007e1802d21d53bed7efa629758ed8289247b0d704171a6b58dcd"
    sha256 cellar: :any,                 big_sur:       "dd2bb23ecfff680c8865c99d4cea248cba12db173175c39d6fe2cf21f8f2651a"
    sha256 cellar: :any,                 catalina:      "bc51ba72a1e5832686e2bcc52092a6224686d5156f989dad3cc272a475e10861"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/propro@5.6"
  depends_on "shivammathur/extensions/raphf@5.6"

  def install
    args = %W[
      --with-http
      --with-http-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/propro@5.6"].opt_include}/php
      -I#{Formula["shivammathur/extensions/raphf@5.6"].opt_include}/php
    ]
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@5.6"
    inreplace "src/php_http_api.h", "ext/propro", "ext/propro@5.6"
    inreplace "config9.m4", "/ext/raphf", "/php/ext/raphf@5.6"
    inreplace "config9.m4", "/ext/propro", "/php/ext/propro@5.6"
    inreplace "config9.m4", "$abs_srcdir", "$abs_srcdir ${HOMEBREW_PREFIX}/include"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
