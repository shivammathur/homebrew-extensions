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
    rebuild 4
    sha256 cellar: :any,                 arm64_monterey: "ba191c29ddc489aba5ce8b2ce8fc937e7667a28fbe2dfd532bbd519654c0b40c"
    sha256 cellar: :any,                 arm64_big_sur:  "6ec861061676758833ed0f12e0b964d6c591be36c2c9dfc35b09e02335c5b5c4"
    sha256 cellar: :any,                 monterey:       "f4cf061e47ca0491d2554e2b7d28875f8651d9df1baaefe06f52904aeebf5bf6"
    sha256 cellar: :any,                 big_sur:        "68907a38fbfbc30b7eafec0bd0a4c73513da6a5d8152eea940c204ccaa0809d8"
    sha256 cellar: :any,                 catalina:       "4b57bb433b30440f3a1b7f6625d05f0a45437e9f94a6f15854eec0e5076e2b6d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8dc3bb0d037db08df279fad6ca52766b37c75d2845484e5a8439e800013173a7"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/raphf@8.2"

  priority "30"

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
