# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT70 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_monterey: "567933712d74e96e48de134710f932742e60c430bd44b4c8c1c1f521f3f2cd47"
    sha256 cellar: :any,                 arm64_big_sur:  "7912cdc114b299a739ce519e12d6faaf4c0230d03edd730ba5de7df244453f98"
    sha256 cellar: :any,                 ventura:        "8ed05b19ed872b1140f935a1a0a1083e21769d1fc67be0fd65786d2766750cce"
    sha256 cellar: :any,                 monterey:       "98954e58aacf5ea6058fded7dfff7f16071fda2267c74edb0fd39b7a91a49d81"
    sha256 cellar: :any,                 big_sur:        "6c24d2a14b131f31d1467562252263f51065f068f8fb4e54d4fa1830adfa0f8e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4e389c8b3014d078d2609f402343c1b0419ca46c0c142d3505c10103e3bbed25"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/propro@7.0"
  depends_on "shivammathur/extensions/raphf@7.0"

  priority "30"

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
