# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT71 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-3.3.0.tgz"
  sha256 "9194524be3997328b6788ef37e37485253e03eadc4bf51abd740358d03d2f536"
  head "https://github.com/m6w6/ext-http.git", branch: "master"
  license "BSD-2-Clause"
  revision 2

  livecheck do
    url "https://pecl.php.net/rest/r/pecl_http/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "6baeb7f066cd3273eaeaa21b766f3c189d0c5d02c85c57d1cfd3d5bf887d4600"
    sha256 cellar: :any,                 arm64_sonoma:  "308c32c9a41947c2d3ad6f9d4f34efd52c7739a389a03b64044bbd556a7d917b"
    sha256 cellar: :any,                 arm64_ventura: "11db53a86f8e9d80271310c25cc543442c1369ed939b6202fbb55b19bca2fe3e"
    sha256 cellar: :any,                 sonoma:        "d5acc0f9a64e722f047acdfc587624c80d01b3e01d12a12ee69706c71bc9b42d"
    sha256 cellar: :any,                 ventura:       "920897b6a8e8cd5a53e29d412868f5d7682a32a4118de4483f1ab51439e6cc57"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "75d2ba864fb1f6b430a3c33465d60290d47b640b367f39a4ac814c1dcaa54c32"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "038779d8ee54b9eb1208bad3a591997599115bd04f987907c18a8e36efc0f8fd"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c@77"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/propro@7.1"
  depends_on "shivammathur/extensions/raphf@7.1"
  depends_on "zlib"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{Formula["zlib"].opt_prefix}
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/propro@7.1"].opt_include}/php
      -I#{Formula["shivammathur/extensions/raphf@7.1"].opt_include}/php
    ]
    # Work around to support `icu4c` 75, which needs C++17.
    ENV.append "CXX", "-std=c++17"
    ENV.libcxx if ENV.compiler == :clang
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@7.1"
    inreplace "src/php_http_api.h", "ext/propro", "ext/propro@7.1"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
