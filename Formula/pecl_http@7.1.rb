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
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_sequoia: "213c859ed49f6b9f22289e716a43677006ea802b7e6fff1c23624183c8dfddb4"
    sha256 cellar: :any,                 arm64_sonoma:  "4b8d2e6ce3ea050deeefa437e1793b49e5e8b760f8658df12e2dcfc4073d80d6"
    sha256 cellar: :any,                 arm64_ventura: "bab682c1a79d5e857a3fb9548b26618bae259b71c24bb08ce3f6f9e5d39b769e"
    sha256 cellar: :any,                 ventura:       "81063b391cfd343823575e65e254ead6140f7f6e94d711ce33b04468f7ec518d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "33f37b1d10a57ecd33bdaaf1b479dbcba5d4ec2d5335646ab8663db8f074166c"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c@75"
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
