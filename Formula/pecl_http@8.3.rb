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
  revision 1
  head "https://github.com/m6w6/ext-http.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/pecl_http/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "1d73864e6f708f8247f55d3fbdd78b2726cc18a663596b93b38ea3dc6473ce6e"
    sha256 cellar: :any,                 arm64_sequoia: "8fbba43dcc58e2656faf31faaf0887624279c1d56ee06cfde2c2732e50640dcd"
    sha256 cellar: :any,                 arm64_sonoma:  "0d9137b2600c941a21dba0125ef909f5df402c0579d7dba159dd3ddee71d1d96"
    sha256 cellar: :any,                 sonoma:        "1189267b864c77d39e8940f216be5e07a4733614507b77e6ffc67668d0fa3c01"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "025e8a7add4fdcee9eee73467f50519d730c78233bac312a673f99d537e16909"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4ff43993306c66a0ed151565198f43e1102dddf0e941157861afc0d9e5a376d1"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c@78"
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
