# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT85 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "d60ba2ec165fa20f69be62df2eec17c61d693deda6903c6ce9b31511cc1962f8"
    sha256 cellar: :any,                 arm64_sequoia: "e41190eb88c6f690b0decb97825bafb1a45d034131b522a277309900820a806e"
    sha256 cellar: :any,                 arm64_sonoma:  "33435b8274271e54f9b9d149baf353171b42fbbb0d3d127977e64ad055821c70"
    sha256 cellar: :any,                 sonoma:        "48cbd6ca4f7f0806406c1efc0fc20e635e21f3322b93532dcf313a3be7e8668c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "32ebfca997dc4da6c9bce72ef8d7fceb19c08c11344c6275e8565914e6b99bcc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "30b6e13cc7d78e4b01b5dcefc33cbed65e98dba09b92d2d4731a423ae03d224c"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c@77"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/raphf@8.5"
  depends_on "zlib"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{Formula["zlib"].opt_prefix}
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/raphf@8.5"].opt_include}/php
    ]
    # Work around to support `icu4c` 75, which needs C++17.
    ENV.append "CXX", "-std=c++17"
    ENV.libcxx if ENV.compiler == :clang
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@8.5"
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
