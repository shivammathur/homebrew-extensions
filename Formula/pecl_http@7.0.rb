# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT70 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-3.2.4.tgz"
  sha256 "37354ff7680b9b9839da8b908fff88227af7f6746c2611c873493af41d54f033"
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256                               arm64_big_sur: "3de70b31e11f8e7e5f177e2bfe91062419cc51061447b2497f4e8146eda82d78"
    sha256                               big_sur:       "052a01bbe1f5c615d4dba54f92c535a29665504ce81ab7dc7b20396357374b95"
    sha256                               catalina:      "f4f0670fde55cd7adb377d3e16a2ed21a9c24d6a9d16851b3d443ef728b05d08"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "50eb802a0fe5de414be444105cd4915796e2bf0b4149e15b5e093d3c0938b2d2"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/propro@7.0"
  depends_on "shivammathur/extensions/raphf@7.0"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/propro@7.0"].opt_include}/php
      -I#{Formula["shivammathur/extensions/raphf@7.0"].opt_include}/php
    ]
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@7.0"
    inreplace "src/php_http_api.h", "ext/propro", "ext/propro@7.0"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
