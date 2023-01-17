# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT74 < AbstractPhpExtension
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
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "693982183165ca697e8b6e352a507b0f6a77d0f3a03c097825b53a8f0f5c481d"
    sha256 cellar: :any,                 arm64_big_sur:  "f5b02c61bdf22c0ea8c34566327e818546d02a07b3512a4f265fd27e0fc22755"
    sha256 cellar: :any,                 monterey:       "5dfc4ca5103fcd2a7d96daddb69f29093ab3c2804718933d5e513a4093c06e0f"
    sha256 cellar: :any,                 big_sur:        "e7122f88b22e85a7fe32b5ad6e99dd14fabd1f5288eb12ef666c27625d5838a0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9a95be947b418309f7c4da39f9e01c034bab8b70c2d207f2926caf4d19870981"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/propro@7.4"
  depends_on "shivammathur/extensions/raphf@7.4"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/propro@7.4"].opt_include}/php
      -I#{Formula["shivammathur/extensions/raphf@7.4"].opt_include}/php
    ]
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@7.4"
    inreplace "src/php_http_api.h", "ext/propro", "ext/propro@7.4"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
