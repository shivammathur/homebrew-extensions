# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT72 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-3.3.0.tgz"
  sha256 "9194524be3997328b6788ef37e37485253e03eadc4bf51abd740358d03d2f536"
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_sequoia:  "afdc05be48de676256b81395924a333e003770a928c0ee2f08dd23edfbe55883"
    sha256 cellar: :any,                 arm64_sonoma:   "5fd74d142d796045bd236b295e51cfc9dbe2d745a1592f5a2ad0111afb675e27"
    sha256 cellar: :any,                 arm64_ventura:  "9a2b67b765dae3ccf088b75afcfc6e69981711c47817c8b6e8f1870edb805b46"
    sha256 cellar: :any,                 arm64_monterey: "9381a300e06b0ca2c25937e7d7202e6f03ad7183b2d57b90de2574f9bda6ad9a"
    sha256 cellar: :any,                 ventura:        "67d31a27f7a754e4baf819e99e169c8ba918fce79e549012a5ed0d73893f79fc"
    sha256 cellar: :any,                 monterey:       "ecba2b9dfb44c7d6302ba4a8d26fb6a051ff123ad980325a72b4e6f65f52a5f1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5637e8d2a9a8ac4a7d3ffb9b562f100f5c2c60708877a9b2b2656377bebdf26a"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/propro@7.2"
  depends_on "shivammathur/extensions/raphf@7.2"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/propro@7.2"].opt_include}/php
      -I#{Formula["shivammathur/extensions/raphf@7.2"].opt_include}/php
    ]
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@7.2"
    inreplace "src/php_http_api.h", "ext/propro", "ext/propro@7.2"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
