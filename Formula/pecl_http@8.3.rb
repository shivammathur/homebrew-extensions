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

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "9d82ef6d48c3130032d22315f46d4d86a49ea0fd13b1b5ab6273b672bc1d4def"
    sha256 cellar: :any,                 arm64_big_sur:  "35626657f1b3fa34894162f02279ff3acb88a601770a4d951002a5300554472f"
    sha256 cellar: :any,                 monterey:       "622fba76051a7b0f8e8d5d4fbf3780e0f9e446aaa10123f82bc03feb84eabd71"
    sha256 cellar: :any,                 big_sur:        "6017436d2645ad8ff95044d69ea8c43a7f758fdf93736b19d6db6699f05cb63b"
    sha256 cellar: :any,                 catalina:       "e01a90c84c669714a68202219b580a5a0a783d4dadb4c068345cec418715a213"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "44fb5d9ee3090550801f77958d303cfecc62c411aec0239f3c1ef80914d9f5b8"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/raphf@8.3"

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
