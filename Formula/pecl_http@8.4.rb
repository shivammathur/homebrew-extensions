# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pecl_http Extension
class PeclHttpAT84 < AbstractPhpExtension
  init
  desc "Pecl_http PHP extension"
  homepage "https://github.com/m6w6/ext-http"
  url "https://pecl.php.net/get/pecl_http-4.2.3.tgz"
  sha256 "fa2ab558fc8f0928a10f35c0f566f7c4a1d32e727bd3a96579e4c28482ee9d6a"
  head "https://github.com/m6w6/ext-http.git", branch: "master"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "100dbd265e7e95136d8b80bd9119cb3fc63cd0b44991542688dea8ef5367c11d"
    sha256 cellar: :any,                 arm64_big_sur:  "c3fb84428d2c201d10b07c5e1fa9ad276ebbba0b6e75027294ec6b588419c676"
    sha256 cellar: :any,                 ventura:        "4e54f23ebd5b1a35bb8cc9d7a280e5af0974f634126eebe7f97cb4cec87fe2ca"
    sha256 cellar: :any,                 monterey:       "7d441a27d3abdfcda5eb43dc87be04627484e6ff3a23dcfb43eec2cbea4d6c65"
    sha256 cellar: :any,                 big_sur:        "065f0e2e17a031960a29a2bb2601060bf44534d946cf841e8c5dc4231bc594ef"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d68f55de1b5ecc2e1b5250146b08e1b1d9b7200f343ff08805e56fbfddc7b74f"
  end

  depends_on "brotli"
  depends_on "curl"
  depends_on "icu4c"
  depends_on "libevent"
  depends_on "libidn2"
  depends_on "shivammathur/extensions/raphf@8.4"

  priority "30"

  def install
    args = %W[
      --with-http
      --with-http-libicu-dir=#{Formula["icu4c"].opt_prefix}
      --with-http-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    extra_includes = %W[
      -I#{Formula["shivammathur/extensions/raphf@8.4"].opt_include}/php
    ]
    ENV["EXTRA_INCLUDES"] = extra_includes * " "
    Dir.chdir "pecl_http-#{version}"
    inreplace "src/php_http_api.h", "ext/raphf", "ext/raphf@8.4"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
