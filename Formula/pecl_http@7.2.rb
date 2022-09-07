# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT72 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-3.3.0.tgz"
  sha256 "9194524be3997328b6788ef37e37485253e03eadc4bf51abd740358d03d2f536"
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "4d00a7195cc7b442ad63f2e4a9d2cca84cc1814409bd1f344f37b7834df1aac1"
    sha256 cellar: :any,                 arm64_big_sur:  "1772b077ea088393b87d00875db176b2e4b19be51e8e89eab28faa88cbe8618b"
    sha256 cellar: :any,                 monterey:       "1439b026b4c76d5f5cbbc7e2f509c3e900e281387bf36fddb4c12c74be486340"
    sha256 cellar: :any,                 big_sur:        "e839dba3c453cf7bc5d23d0e9ce7b16634d907b6ef289082eecfc26bb6018b3a"
    sha256 cellar: :any,                 catalina:       "862b041b3b59bea9a1a641e35b44425b7afdfeaf80d39b22fea825e93c2c5228"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7170541b6f40c5d73d51d6fbd0724d738f09b49822cfa87e0d43530ec2842864"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/propro@7.2"
  depends_on "shivammathur/extensions/raphf@7.2"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/propro@7.2"].opt_include}/php
      -I#{Formula["shivammathur/extensions/raphf@7.2"].opt_include}/php
    ]
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@7.2"
    inreplace "src/php_http_api.h", "ext/propro", "ext/propro@7.2"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
