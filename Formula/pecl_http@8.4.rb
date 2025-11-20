# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT84 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-4.3.1.tgz"
  sha256 "1512dc02fea2356c4df50113e00943b0b7fc99bb22d34d9f624b4662f1dad263"
  revision 1
  head "https://github.com/m6w6/ext-http.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/pecl_http/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "8c8c0ee7a640c88d81cf5d24baf1c4496bcc7d6c6d17f0d2edfa1dcb0fc54993"
    sha256 cellar: :any,                 arm64_sequoia: "b8ee3fbd39281164d5a99ad43a21563d9f3d3874e30e750ca9cf7a17ee1c8a89"
    sha256 cellar: :any,                 arm64_sonoma:  "9d4a242d5d31baa35818cac21f88ec6d35f82e84978e7447b6ba0c56ddfd5e50"
    sha256 cellar: :any,                 sonoma:        "656aaf0c46053d99806c32b70d1156d4e8953b18b50d8f74a7633aa11ed64fd8"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "68a65c29bc0bff5a2946780fc11b66243c1f742f98bf82d4e5e887de021c6797"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "709f371e458dc96f8a9d1f1cb12356e8ecac036beb1b916c449676a539e8ec6b"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c@78"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/raphf@8.4"
  depends_on "zlib"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{Formula["zlib"].opt_prefix}
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/raphf@8.4"].opt_include}/php
    ]
    # Work around to support `icu4c` 75, which needs C++17.
    ENV.append "CXX", "-std=c++17"
    ENV.libcxx if ENV.compiler == :clang
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@8.4"
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
