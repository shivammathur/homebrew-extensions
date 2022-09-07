# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT81 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-4.2.3.tgz"
  sha256 "fa2ab558fc8f0928a10f35c0f566f7c4a1d32e727bd3a96579e4c28482ee9d6a"
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "b57815411794f42d890b02a9906e7ded38b597bb04f55c0a20c3932c5edb4b58"
    sha256 cellar: :any,                 arm64_big_sur:  "0ce2fbdbaf66f45b6ede22a7b617476dc36335a18fd7cb85dad2c3dccee3918f"
    sha256 cellar: :any,                 monterey:       "3f18692fad19c49407d21cd2cfeb0ed829727a59a907f177a8087f32dc10e114"
    sha256 cellar: :any,                 big_sur:        "c0ddcb4cb40d9dfa06d78edaa397244fe66a1c0b77093c352a26d6bb8b1e6c29"
    sha256 cellar: :any,                 catalina:       "3a9ccfb153bbccf63f6bb31182ee290de527b7c0943935537f048eb7ed985b30"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ee0684cc61322b3f36391498cdf63e81b7698f109fbb74ee708fc4881fbfa217"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/raphf@8.1"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/raphf@8.1"].opt_include}/php
    ]
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@8.1"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
