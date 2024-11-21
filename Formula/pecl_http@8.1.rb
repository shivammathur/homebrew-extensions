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
    rebuild 4
    sha256 cellar: :any,                 arm64_sequoia: "7364c5d9dc1551c816f337cf912c878337820a19968b22ea77e7b7b8964cc5bf"
    sha256 cellar: :any,                 arm64_sonoma:  "6d271ccafc3e4b34cb6c61ad6ede390c56bfaea205961dbf5d3c838b4c56437d"
    sha256 cellar: :any,                 arm64_ventura: "19824afa18254ade52022f0f44ad7e8f26b821aa39cb47710618f9457130dcb0"
    sha256 cellar: :any,                 ventura:       "543ab65645046928f280c52d02020ac4bd6a1b0d754937e700143eeacedc286c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ca48ee6cbec0084c9a6694de4755ed8cff6e0f612a8324a8b6549f580af4ffae"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c@76"
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
