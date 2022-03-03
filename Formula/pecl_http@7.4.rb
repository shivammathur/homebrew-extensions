# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT74 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-3.2.5.tgz"
  sha256 "38f9345cee2e60b4919af73a6a291e1d3b90543c61edc9def6bd783f3b100728"
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "9f401ae22753de83fcb7e5d1fcc1fc4a459ae84ac9606a83af1dd73958703835"
    sha256 cellar: :any,                 big_sur:       "7c46cc6dcbf4769347d6fdf3faaea9a9cbb46af067947b8dc85197952d9969d0"
    sha256 cellar: :any,                 catalina:      "3d0b715957a99d0b31fdd847d55a88618793bbf72856f469a9a67c358f669c95"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2de1bfe368a6d135a7202d687ddac9e2ef9b15228563f7d063d101cba05b5e66"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/propro@7.4"
  depends_on "shivammathur/extensions/raphf@7.4"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/propro@7.4"].opt_include}/php
      -I#{Formula["shivammathur/extensions/raphf@7.4"].opt_include}/php
    ]
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@7.4"
    inreplace "src/php_http_api.h", "ext/propro", "ext/propro@7.4"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
