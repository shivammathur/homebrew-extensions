# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT83 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "92c956e249efe0985598f10c0dc6e3e6a43b9f07c1a3255db81ac24b2550d9c6"
    sha256 cellar: :any,                 arm64_sonoma:  "01591ffccfb1d319a97851519d9f0890b950ff8e659a31a2433d0b9ef78b0eb7"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "432e622cfb72bb4340183ddaa786bddc240eb531848b92d9a4d9b0ba2f95d2d8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "16c481243f4fee0f3db2f45b3007450a06981e679fc92cb8c7005a77860bcaee"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c@77"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/raphf@8.3"
  depends_on "zlib"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{Formula["zlib"].opt_prefix}
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/raphf@8.3"].opt_include}/php
    ]
    # Work around to support `icu4c` 75, which needs C++17.
    ENV.append "CXX", "-std=c++17"
    ENV.libcxx if ENV.compiler == :clang
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
