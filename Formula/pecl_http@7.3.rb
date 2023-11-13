# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT73 < AbstractPhpExtension
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
    rebuild 3
    sha256 cellar: :any,                 arm64_ventura:  "551fcf0e54edb2930cd1874b376e07ed5313e0190f7ca9adaa0a0a0493de649b"
    sha256 cellar: :any,                 arm64_monterey: "3a0337eb0e67bf47578bad33edb681dc46cbbf49c018ddfdf658535c93984db6"
    sha256 cellar: :any,                 arm64_big_sur:  "29d0b56515849e96de11e4ba2236af1fdcb06f810b9dbe8cd7db07f48a3bc53f"
    sha256 cellar: :any,                 ventura:        "94d8bbf0d475feeedd28b4ff264ee798babb97dc18346493884007586f777408"
    sha256 cellar: :any,                 monterey:       "4874674a7a85d0d92a309a6c8d549ff50443f22c679787551476da790a9430c5"
    sha256 cellar: :any,                 big_sur:        "eeb0a98f85bf7ede7bf2e36ad150bfb44be461d2f99a05daf48d0e5c6d0f06bf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f46914a39fcc561ca3523f9f5de0ff33c1acd3381d3f5d5c0cb2953f43c3ac20"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/propro@7.3"
  depends_on "shivammathur/extensions/raphf@7.3"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/propro@7.3"].opt_include}/php
      -I#{Formula["shivammathur/extensions/raphf@7.3"].opt_include}/php
    ]
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@7.3"
    inreplace "src/php_http_api.h", "ext/propro", "ext/propro@7.3"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
