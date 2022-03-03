# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT73 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-3.2.5.tgz"
  sha256 "38f9345cee2e60b4919af73a6a291e1d3b90543c61edc9def6bd783f3b100728"
  head "https://github.com/m6w6/ext-http.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "670dab0cf9adf627dcee96d4594a677107c38637a0e9d8bc7dd637d20b4de680"
    sha256 cellar: :any,                 big_sur:       "487800bb8c33cf8e4f59ec2ccd199c53298f4e21f8c99d0ba8fdc2026219d7ad"
    sha256 cellar: :any,                 catalina:      "acef61edc6925957f8a350da398b17a1e26c7053d273ccc824d6277e54ec0e12"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e860e73498908d7b13792bb5796c62dbabf21f36f9559fe9fff6a5f693ff182c"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/propro@7.3"
  depends_on "shivammathur/extensions/raphf@7.3"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
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
