# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT71 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-3.3.0.tgz"
  sha256 "9194524be3997328b6788ef37e37485253e03eadc4bf51abd740358d03d2f536"
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "c6ce4f3a7c644bb536ba870cac8a454eaffe73fb740d2c829a04a5629d81173c"
    sha256 cellar: :any,                 arm64_big_sur:  "6c66655e951a3bb8863818e902f3b82c190ab2b376364c0e68c1f5e41a136c30"
    sha256 cellar: :any,                 monterey:       "65ff59d168a7ae51e73f589892f8c4fd377aa2703e1280211357d964d6f8e2db"
    sha256 cellar: :any,                 big_sur:        "d0e221d0f08c401d0e30238a38f581d87ef9ce0878a11def464f6d5a5eb3618b"
    sha256 cellar: :any,                 catalina:       "3ab41495cbdbe71f7386447c4696bc09ec74e2f1c4578936045ba3b86c8430a6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "80efa768b178cb8f807a3d629f678b82a4b4b7e89ce2996cce896a594e14a189"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/propro@7.1"
  depends_on "shivammathur/extensions/raphf@7.1"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/propro@7.1"].opt_include}/php
      -I#{Formula["shivammathur/extensions/raphf@7.1"].opt_include}/php
    ]
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@7.1"
    inreplace "src/php_http_api.h", "ext/propro", "ext/propro@7.1"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
