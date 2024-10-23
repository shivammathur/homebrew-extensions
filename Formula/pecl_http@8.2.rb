# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT82 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-4.2.4.tgz"
  sha256 "fb1e10c2e5edfb011ff8dc2e473cdbd2bbe0127d1279dfce4d98570555ac6ded"
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia: "790da67afd63c81928194f7d2a232c0fe674a5f691bf71f33bc907e4048886fc"
    sha256 cellar: :any,                 arm64_sonoma:  "257dd081e2d4896698af98c37923ddaa5ea14905ff1fce30af894879fc8f8378"
    sha256 cellar: :any,                 arm64_ventura: "9680c9c95a2838d88ec85288271ae40df1c8b9f14dd34deb1c29171681c9bee7"
    sha256 cellar: :any,                 ventura:       "2eacc9c70f208cf1622c5df81744148ae52d716543f7cf08df23d31f02b33876"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fd02c0eab607db8b66b102df525b220bbaf3b5e24c79165433b2b9705607a1ab"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c@75"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/raphf@8.2"
  depends_on "zlib"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{Formula["zlib"].opt_prefix}
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/raphf@8.2"].opt_include}/php
    ]
    # Work around to support `icu4c` 75, which needs C++17.
    ENV.append "CXX", "-std=c++17"
    ENV.libcxx if ENV.compiler == :clang
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
