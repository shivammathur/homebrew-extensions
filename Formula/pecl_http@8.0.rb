# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT80 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-4.2.4.tgz"
  sha256 "fb1e10c2e5edfb011ff8dc2e473cdbd2bbe0127d1279dfce4d98570555ac6ded"
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "df2d501486ae167da9b90b9972d544e8df8ecee551a9c5848b0b8d9839fbd28d"
    sha256 cellar: :any,                 arm64_ventura:  "a0282e1594cd34c762359828dc5231439d00ffebb793d9c2ff2c7d6337f145a5"
    sha256 cellar: :any,                 arm64_monterey: "74e923cae95918bf15065ee217db0e1097c971c94828336c728b4d4f7cd9128c"
    sha256 cellar: :any,                 ventura:        "01d3c23518b59c2f75d5c9033a65c02d797651cd45bd2de2c84dd7c4bdc020fe"
    sha256 cellar: :any,                 monterey:       "06e1036541eb52b91f6d58a0ed90eff1234c1370c43eca4d14755cf8277ffe5b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2e775796148cd8347254b2555d1f89579cd6c925f4c926a5d1197395dd327b77"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/raphf@8.0"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/raphf@8.0"].opt_include}/php
    ]
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@8.0"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
