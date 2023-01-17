# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT83 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-4.2.3.tgz"
  sha256 "fa2ab558fc8f0928a10f35c0f566f7c4a1d32e727bd3a96579e4c28482ee9d6a"
  head "https://github.com/m6w6/ext-http.git", branch: "master"
  license "BSD-2-Clause"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "8180511f59d7f252f3b9fd50280a4cb75227ab1a238125eaad4c1dcf4b7e3498"
    sha256 cellar: :any,                 arm64_big_sur:  "71667b45bd82c933c956b685e24e2072d480d3b3f3540078a5e2b02fc7cab403"
    sha256 cellar: :any,                 monterey:       "9727899210bc37cdd5d9d1a1a1bee2cca66b75c32b5f120df66ea337e7a1a6ed"
    sha256 cellar: :any,                 big_sur:        "27ada7e25512e90d66214e5bcb2fb977a57a4b4a28621eb2569acc84ffdd2c88"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0111ae617a66cac94ee316f251020fab77f9ddc2763facddfc5a3c9c244f6b4d"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/raphf@8.3"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/raphf@8.3"].opt_include}/php
    ]
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@8.3"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
