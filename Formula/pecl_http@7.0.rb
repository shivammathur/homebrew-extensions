# typed: false
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

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "40a938310b079fc701c64c285b732e2c669499ad200da1a6d6f0b874b8da847e"
    sha256 cellar: :any,                 arm64_big_sur:  "2570cda370f94d2dd26e2e59c1133ded334abe27e50bab0a2f7675e4eac93a03"
    sha256 cellar: :any,                 monterey:       "56b837873763ae9769005e49bebe756efd184f27d9bcd99ab34754a5d9675360"
    sha256 cellar: :any,                 big_sur:        "173b8ff8be502c66c8ea873287f1a9a5bdb014cf81aa6e8159f7648ac36e6543"
    sha256 cellar: :any,                 catalina:       "ed58fb568c3ca395f83d6e33f3cbf56ba2bffcc9df982414674542ef31e6f133"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "cc46fcdedb17d6e3a3753dab953bb21fb965bd40545ec3655de92dbf4da757c0"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/propro@7.0"
  depends_on "shivammathur/extensions/raphf@7.0"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
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
