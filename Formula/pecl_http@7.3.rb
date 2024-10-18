# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT73 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia:  "74a5663773f0f182ad31b8cba42f33538658647b7e490953018dc97bd3227420"
    sha256 cellar: :any,                 arm64_sonoma:   "ffe6b128aafce2a7149979721c57ac1f1a50a6624998b7f4a33539a243c403b7"
    sha256 cellar: :any,                 arm64_ventura:  "2ea22bda4b000dbb144aa43ceede5c02635457dc3730dfb6d1c60ad04d09f97d"
    sha256 cellar: :any,                 arm64_monterey: "c49c74da056571ccca281bd5755921061b0e067966852288434366ec8878a217"
    sha256 cellar: :any,                 ventura:        "bfd1567316083d662a20884c387132c5862f8307d52a16e3e1b093617133a202"
    sha256 cellar: :any,                 monterey:       "ef5d6d232f85d1ebb78d217cbbf79a6a30241fb7e6e126b69cb4659c617ec7a5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "efeb43d5a63619356f04f6362d040c94e6568c8b4f79596a141e6b965edec17a"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/propro@7.3"
  depends_on "shivammathur/extensions/raphf@7.3"
  depends_on "zlib"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{Formula["zlib"].opt_prefix}
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/propro@7.3"].opt_include}/php
      -I#{Formula["shivammathur/extensions/raphf@7.3"].opt_include}/php
    ]
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@7.3"
    inreplace "src/php_http_api.h", "ext/propro", "ext/propro@7.3"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
