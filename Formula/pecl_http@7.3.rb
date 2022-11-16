# typed: false
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
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "fb850f753de670f111d0c626555d950274f0720a18d95300e8c39ef4f35e138a"
    sha256 cellar: :any,                 arm64_big_sur:  "c61dbe1030ee15a4352720b3d3431b78e234dd377b71396a822fe16c54b97e80"
    sha256 cellar: :any,                 monterey:       "981740291fedf725e0fd709a0dd265478af10184914e94f28366e00f0298c9a5"
    sha256 cellar: :any,                 big_sur:        "a6a817cbb36a2f3154ddc7cb3cd9d4a65cd2a982df7628e8d9f0ba903da65094"
    sha256 cellar: :any,                 catalina:       "08d348d60d4923011143ebaec5d8557b18e6e5ed567986009193eff869fac7fa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "be548e9a726d60d0e2388f54ef34e90c9f2ec4ff70d1f699859bb773fdb5876a"
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
