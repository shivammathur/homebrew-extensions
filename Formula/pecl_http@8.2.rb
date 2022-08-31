# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT82 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_monterey: "6142bc5ab75787a05c2776dd2883c8e5f44a1a84803bd767a00198b5ef638af6"
    sha256 cellar: :any,                 arm64_big_sur:  "22dbc7fb6a3159d5cb679ffdc02786135a6aff05ccf8f3961acb6e19204da5a5"
    sha256 cellar: :any,                 monterey:       "5c4bcc5716fda1c1995430f5c1a2102a10f88a75d44cb967f31252a6a53bb79b"
    sha256 cellar: :any,                 big_sur:        "17ee44e3dbccaff7f4cafe09ae20dc0af7b7cc6df5a9885cdc0fce297572c789"
    sha256 cellar: :any,                 catalina:       "4cdefeb301060cf4b0d1c99744d0e18b1c1bd4ca5608148d93975f5c875510fe"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "97088714a798e59475917d1846f970b2227bfba36b01b64dc5c3799a915b761c"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/raphf@8.2"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/raphf@8.2"].opt_include}/php
    ]
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@8.2"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
