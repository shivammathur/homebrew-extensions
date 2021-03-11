# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT81 < AbstractPhp81Extension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-4.0.0.tgz"
  sha256 "ea9a508578cffd428baf7b78f6d1618badedf3175be06b0809588a8b48889d5f"
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"
  revision 1

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 1
    sha256 arm64_big_sur: "118f3c37f1aebeb45818aaae31c25c8f994344c374e8fab86860060ef965a536"
    sha256 big_sur:       "f5ca05571154dd3541b9a7a5bd30a0dbc23f7e567f942a8a108247a166995bd0"
    sha256 catalina:      "5638572cbaff493421c86d63a20b0723b5b04ced08cea2d375f4155f4c473014"
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
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@8.1"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end

  def module_name
    "http"
  end
end
