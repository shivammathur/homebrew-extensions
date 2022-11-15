# typed: false
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
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "b09845c5e26a99cac4a1fb2f63f54318b8fb3bb8e516f833ce4ac52bec8325b5"
    sha256 cellar: :any,                 arm64_big_sur:  "10c8e076d430d564ed9891a93cea77b90ba690544d15b3839393acec917c1171"
    sha256 cellar: :any,                 monterey:       "5db1b11b10e9e1da50dc3affdb0fa5f53b7beb983d354760614339929ee59a5c"
    sha256 cellar: :any,                 big_sur:        "fc62afa0e5f3888f0dad21522817aee1691b96640155ea7387a6e0d390499ebc"
    sha256 cellar: :any,                 catalina:       "33e0277dd103dfa4bf4ca2bd5b64e3d2363a45a6aa374684ae58991f75160312"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bda1d83804e866bc6a23820c75e2f33550dfc2d83841f56d90b2ee37cb99c963"
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
