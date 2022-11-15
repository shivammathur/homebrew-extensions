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
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "96346aa25bba515cdfff43ddf5c0fa13b521b0a59e70e8310d4e813cbee993ca"
    sha256 cellar: :any,                 arm64_big_sur:  "1d25c6a6bd11898717bc9ab053fe2504b600f22e3e18a5baf14ffd3983dd06d5"
    sha256 cellar: :any,                 monterey:       "3f17c1f20e7dd035b15b98c418b1592a679516743e4c556232d8d67eec6056a4"
    sha256 cellar: :any,                 big_sur:        "f419805662040afcc1fe5261778d34aa62bc19586e41080ef680f1a9600bd2c4"
    sha256 cellar: :any,                 catalina:       "a976dc8356a3b6a9db239520b7a63631ad7fe28f41146fb324115d28c9290887"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5fae2c7dfda85fb8d4e7d76ca1b3aa140cc3077c75e59258dd86aa8d101befed"
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
