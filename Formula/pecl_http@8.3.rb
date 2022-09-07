# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT83 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-4.2.3.tgz"
  sha256 "fa2ab558fc8f0928a10f35c0f566f7c4a1d32e727bd3a96579e4c28482ee9d6a"
  head "https://github.com/m6w6/ext-http.git", branch: "master"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "1aa75755c1ba43232aa7ff1dafbf5f8b559644d142dd54301532cc478a7e7dfc"
    sha256 cellar: :any,                 arm64_big_sur:  "d5542e6933b2505e62838f381c4682ca31ce579d9a71189673f2a23a633bca04"
    sha256 cellar: :any,                 monterey:       "00a27e0b77c4917f9b9bfed7214b1f29606b907b37ea6dcb73db81e32e01d1f9"
    sha256 cellar: :any,                 big_sur:        "48c2e614a553d6a312ef3c0ffcf14ac65042bea156c78e4f4a137a1b69ae4f36"
    sha256 cellar: :any,                 catalina:       "93afbd96423db9361264e9a117928231f610cf4456d5d8592eb98fe239e8147e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "83521b5fdd8aa98af05d3b6b5a32535288d3009c15ba6baf6575e32c59a12741"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/raphf@8.3"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/raphf@8.3"].opt_include}/php
    ]
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@8.3"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
