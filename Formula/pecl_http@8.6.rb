# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT86 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-4.3.1.tgz"
  sha256 "1512dc02fea2356c4df50113e00943b0b7fc99bb22d34d9f624b4662f1dad263"
  head "https://github.com/m6w6/ext-http.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/pecl_http/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "aea93304373b01f52cce1505c527ec0b38508dc70fdf1812c087e62b51321951"
    sha256 cellar: :any,                 arm64_sequoia: "1af3e6d80ae6fd5f71b03ead0ef32aa8bc4efc15ab74385d9f5f57c8429b0419"
    sha256 cellar: :any,                 arm64_sonoma:  "951173703fe0f6ae66214b7bcfac77f73831774ac2d4141794b70659e59673c2"
    sha256 cellar: :any,                 sonoma:        "93067b0b2ba3cc6a0c4c71898e2535e9677385910c4776ca51b4f39ffd2ed086"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "038c8ce24f073cef652239460297e0ffb80e0a63a2e501c0933311a26accf5b3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "258e5fc53ea910cdf4f8cb530edabe4ddfdc5907b0d30708a1651cdcec2b872c"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c@77"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/raphf@8.6"
  depends_on "zlib"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{Formula["zlib"].opt_prefix}
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/raphf@8.6"].opt_include}/php
    ]
    # Work around to support `icu4c` 75, which needs C++17.
    ENV.append "CXX", "-std=c++17"
    ENV.libcxx if ENV.compiler == :clang
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@8.6"
    inreplace "src/php_http_message_body.c", "standard/php_lcg.h", "random/php_random.h"
    inreplace "src/php_http_misc.c", "standard/php_lcg.h", "random/php_random.h"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
