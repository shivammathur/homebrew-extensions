# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT81 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-4.2.4.tgz"
  sha256 "fb1e10c2e5edfb011ff8dc2e473cdbd2bbe0127d1279dfce4d98570555ac6ded"
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_sequoia: "af7900b8914ae7688c9991300d89df983cfc8c6c99d75cc52addc806c7f6f9af"
    sha256 cellar: :any,                 arm64_sonoma:  "dade68d84b38ec02b97ab1c1a4dfef18d5295df712e74589eb5aa138c2a6af29"
    sha256 cellar: :any,                 arm64_ventura: "126fe4a1488e812193815660e4b9ec2203db39d34e17a5849ae70c5967d0f1c7"
    sha256 cellar: :any,                 ventura:       "dca8f6c0262ea6ec1b5f2b3b93b527000d62e3948c2465a441309a9f8cc85aad"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5dc1b71a31657430374b9cb6878ab02a8e4a180994f9d777185b714f8dbf4e92"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c@75"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/raphf@8.1"
  depends_on "zlib"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{Formula["zlib"].opt_prefix}
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/raphf@8.1"].opt_include}/php
    ]
    # Work around to support `icu4c` 75, which needs C++17.
    ENV.append "CXX", "-std=c++17"
    ENV.libcxx if ENV.compiler == :clang
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
