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
    rebuild 4
    sha256 cellar: :any,                 arm64_sequoia:  "0a8a712907025afe9e4710c45514da830197ac6d4b9da500b9e552e87390531d"
    sha256 cellar: :any,                 arm64_sonoma:   "b41107f12fe12b56545e181474325d54dabe5cb290c3a45a96ea8fc88650c0bf"
    sha256 cellar: :any,                 arm64_ventura:  "7a7abfabd57a9ea7168dca6e199fde90cacc155538e0b60da0dca547b91bf77f"
    sha256 cellar: :any,                 arm64_monterey: "5d18b085be8926bf5c534f1496cd119dd72980a9eface094d290333f3e8421c3"
    sha256 cellar: :any,                 ventura:        "b55e5c158bdb21a05da777fa054ff74664a72be016f73f29cf2e1a47e7c2a3e4"
    sha256 cellar: :any,                 monterey:       "7f084ad35bae8fc8418e928418545e9cf91d64d3339bd6fdfe9b2553689ece7d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b97f25dd21a3ea61e8ee8d1e2e5297bb29acf0b577c93e62be821d176eb8b992"
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
