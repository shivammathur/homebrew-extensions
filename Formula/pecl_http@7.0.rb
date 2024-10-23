# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT70 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-3.3.0.tgz"
  sha256 "9194524be3997328b6788ef37e37485253e03eadc4bf51abd740358d03d2f536"
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_sequoia: "2064bbe112799e05c6f9ca745bcdc7e2628e2dee3978fd285a1d6abc44615ed2"
    sha256 cellar: :any,                 arm64_sonoma:  "ed35535d98a6c13fb3737c377f5ecbc963f74e26e0866f3a343abd748acf2b98"
    sha256 cellar: :any,                 arm64_ventura: "a0d00a6d257a0f29f40d4a5d895734838bc98220495675c8c2d30d66f3e1250e"
    sha256 cellar: :any,                 ventura:       "a0382560c3009e979300e9e60c44b06b3a0d3091881df5b65e132440c252f33b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3d6a32795c16e146059e8ab3bd73140b16264e34cbb14e1f2146ced8c205e48e"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/propro@7.0"
  depends_on "shivammathur/extensions/raphf@7.0"
  depends_on "zlib"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{Formula["zlib"].opt_prefix}
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/propro@7.0"].opt_include}/php
      -I#{Formula["shivammathur/extensions/raphf@7.0"].opt_include}/php
    ]
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@7.0"
    inreplace "src/php_http_api.h", "ext/propro", "ext/propro@7.0"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
